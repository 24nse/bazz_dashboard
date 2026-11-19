// Node.js script to create sample products directly in Cloud Firestore (project: lipsak-97e24)
// Run with: node scripts/seed_products.js

const PROJECT_ID = 'lipsak-97e24';
const COLLECTION = 'Products';

const sampleProducts = [
  {
    Title: 'قميص أكسفورد كلاسيكي فاخر',
    Name: 'قميص أكسفورد كلاسيكي فاخر',
    Price: 189,
    SalePrice: 149,
    Stock: 45,
    CategoryId: 'cat_men_shirts',
    Brand: 'Zara',
    SKU: 'SHIRT-OXF-01',
    Thumbnail: 'https://images.unsplash.com/photo-1596755094514-f87e34085b2c?w=500',
    IsFeatured: true,
    Description: 'قميص رجالي فاخر من القطن الصافي 100% مناسب للمناسبات الرسمية والعمل.',
    Sizes: ['M', 'L', 'XL'],
    Color: 'أبيض'
  },
  {
    Title: 'تيشيرت بولو رياضي قطني',
    Name: 'تيشيرت بولو رياضي قطني',
    Price: 129,
    SalePrice: 99,
    Stock: 60,
    CategoryId: 'cat_men',
    Brand: 'Nike',
    SKU: 'TSHIRT-POLO-02',
    Thumbnail: 'https://images.unsplash.com/photo-1521572267360-ee0c2909d518?w=500',
    IsFeatured: true,
    Description: 'تيشيرت بولو شبابي أنيق وعملي للاستخدام اليومي والرياضي.',
    Sizes: ['S', 'M', 'L', 'XL'],
    Color: 'كحلي'
  },
  {
    Title: 'فستان صيفي مشجر',
    Name: 'فستان صيفي مشجر',
    Price: 249,
    SalePrice: 199,
    Stock: 25,
    CategoryId: 'cat_women',
    Brand: 'Mango',
    SKU: 'DRESS-SUM-03',
    Thumbnail: 'https://images.unsplash.com/photo-1572804013309-59a88b7e92f1?w=500',
    IsFeatured: false,
    Description: 'فستان أنيق بألوان صيفية مبهجة وخامة خفيفة ناعمة.',
    Sizes: ['S', 'M', 'L'],
    Color: 'وردي'
  },
  {
    Title: 'طقم ولادي كاجوال قطعتين',
    Name: 'طقم ولادي كاجوال قطعتين',
    Price: 110,
    SalePrice: 85,
    Stock: 30,
    CategoryId: 'cat_kids',
    Brand: 'Carter\'s',
    SKU: 'KIDS-SET-04',
    Thumbnail: 'https://images.unsplash.com/photo-1519238263530-99bdd11df2ea?w=500',
    IsFeatured: true,
    Description: 'طقم مريح وعصري للأطفال خامة قطنية آمنة على البشرة.',
    Sizes: ['2-3Y', '3-4Y', '4-5Y'],
    Color: 'أزرق'
  }
];

function toFirestoreFields(obj) {
  const fields = {};
  for (const [key, val] of Object.entries(obj)) {
    if (typeof val === 'string') {
      fields[key] = { stringValue: val };
    } else if (typeof val === 'number') {
      fields[key] = Number.isInteger(val) ? { integerValue: String(val) } : { doubleValue: val };
    } else if (typeof val === 'boolean') {
      fields[key] = { booleanValue: val };
    } else if (Array.isArray(val)) {
      fields[key] = {
        arrayValue: {
          values: val.map(item => ({ stringValue: String(item) }))
        }
      };
    }
  }
  fields.CreatedAt = { timestampValue: new Date().toISOString() };
  fields.UpdatedAt = { timestampValue: new Date().toISOString() };
  return { fields };
}

async function seed() {
  console.log(`Starting to seed ${sampleProducts.length} products to Firestore [${PROJECT_ID}/${COLLECTION}]...`);
  
  for (const prod of sampleProducts) {
    const url = `https://firestore.googleapis.com/v1/projects/${PROJECT_ID}/databases/(default)/documents/${COLLECTION}`;
    const payload = toFirestoreFields(prod);

    try {
      const res = await fetch(url, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(payload)
      });
      const data = await res.json();
      if (res.ok) {
        const docId = data.name.split('/').pop();
        console.log(`✔ Added: "${prod.Title}" -> Doc ID: ${docId}`);
      } else {
        console.error(`✖ Error adding "${prod.Title}":`, data.error ? data.error.message : data);
      }
    } catch (err) {
      console.error(`✖ Network error:`, err.message);
    }
  }

  console.log(`\nDone! Open Firebase Console at: https://console.firebase.google.com/project/${PROJECT_ID}/firestore`);
}

seed();

