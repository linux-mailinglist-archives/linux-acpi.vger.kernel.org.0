Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4068A3160CD
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Feb 2021 09:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233793AbhBJIVL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 10 Feb 2021 03:21:11 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:50991 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbhBJIVI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 10 Feb 2021 03:21:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1612945268; x=1644481268;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ef/HUr+YwIRfmYMRAdMuk5LKyTG6ctmot17w10ivCwM=;
  b=D7a/hYhfU2CaG7SK6BUF2e6KJKw1Ej/86Sk3f4eMAiPAQeUS76LzXCWP
   u0LAW3YuFUQCBgPISICcMX+9f76IU3xMRCan7dLQqzxwtOsHM1U7+QWZP
   nRw73ezWYSalmUffiCof2cyzZrgp9ZtVDk7qe8pfecmIv1LnKj391V1eQ
   VWxkDIQdatIDPdaK48NUjUOT4eYfwtUKiWiYUTrNFheA5h0/qMEfHi0J3
   Afj2F7x6d2eHgKMuUAuPul9wjE479McDW1faP61xR4fe7LKYYi3pqab0w
   h2r63LHT40owpPAMmkTG/dyHa8/3V3U0UPvMHQc2bsg6tuGi7hj3z+YOL
   w==;
IronPort-SDR: orX/vksM+pqDBIpIi+28jt98spykc57xpT7i/Bkfatj/12uqFcoNEL1CwiLwEAve5p9BmRiVUC
 KG7XUU3CqM6FP9zsWXn2FfduqpScpqYmyINIMdm9PxnsZgON5YVBDjvJvZkAmfp5Vpffeiwy1j
 ZN4P50DCdpXYs0PfmMHbye3/EF5xuXmMxr+4EcfBerptLKd0fQ2fJJ8kOIsEQf1CxTQOaU4bLH
 drXkESHO5K/CfLV96DwMPq8bx6O+AGmfXV3ImclMcdsh8xOvD2daUnTvDBpWhT5udA7GRxJArz
 VG8=
X-IronPort-AV: E=Sophos;i="5.81,167,1610434800"; 
   d="scan'208";a="103268274"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Feb 2021 01:19:50 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 10 Feb 2021 01:19:50 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Wed, 10 Feb 2021 01:19:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jFnx2ZjKmCHYTCDtb3wJxiJOPdnEx7kX9cM3hEbfwqY8qmuArJPlpwP+0CyZPMVdT88RohdVfJ98oqjsswpdICcitwqshYa2ugWzZPmuCljE+nu1F0oA/82AVES0ntX7BDzTaWQFDZ+tSdWd9RJ66c9J/x9w5jT9moN3+hKpJpNo7ryXTAcBUKsr742ZEPbaH9MrYAK13n54+/4k0eGxCwCfhyZ3XCQnw5wzrpM/J8yHXksmOH+Hq2LmhEjBAg+6IiVeu6Uc1PxT5adHZOhZ9XK57H3+Z6ucTVSVDAyZ8hJDONMn9TX7D/W7vVe5SS8b+f5esyyHl7K9Aq3OPzTePg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ef/HUr+YwIRfmYMRAdMuk5LKyTG6ctmot17w10ivCwM=;
 b=j/Vph5MqZF2tVremAYbOBochTIfV/iVF0gLhlXmqbWDr1WLzH82mYDjnbYu2kD/vyykwyMmJ4MTsaHh/nMiTlVrSMxpnRqGK8K8377J72qtOZbpSWlpx0MhGKRS5GIqcnKrmMLDnGhZYkkZk2wYtNmLvtlC3XPISWISoWavVoiUFgXppPdM3H6gsIwBCT4yADV5/bf2Lwknz0Jmnxj5cqG5sRhRusT3pWxyVeitxIqtPZ58+HYCJv4+IRTiUxRZLVylLMc0V+v63KI/dBkpvdPDtEP5paOtl3K/rYLli+CQWk0zazD2lRYmzUNwnAmuCUaJmxmJts38vQZ1OQMDxqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ef/HUr+YwIRfmYMRAdMuk5LKyTG6ctmot17w10ivCwM=;
 b=KMM4VfTpibPQixFOvwiRPq5vYukHVnK8NZ2pI4IPu8Czp3G3Ea37LEwWOxuRQBrvVwbX/CTY6UF2TdTOUvUdK4dFjlQTNWHwTmVSke2wQwFzI1R+Cr1FOsj7E7vikrI4a8aAzKIXsVvQqz6gRF3A5am+v6iDKgylt4dh+Yicnj0=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SA2PR11MB5130.namprd11.prod.outlook.com (2603:10b6:806:11d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20; Wed, 10 Feb
 2021 08:19:47 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::f4e3:108c:4222:7dab]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::f4e3:108c:4222:7dab%4]) with mapi id 15.20.3825.031; Wed, 10 Feb 2021
 08:19:46 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <saravanak@google.com>, <corbet@lwn.net>,
        <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <khilman@kernel.org>, <ulf.hansson@linaro.org>,
        <len.brown@intel.com>, <lenb@kernel.org>, <pavel@ucw.cz>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <frowand.list@gmail.com>, <maz@kernel.org>,
        <tglx@linutronix.de>, <sboyd@kernel.org>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <m.szyprowski@samsung.com>, <geert@linux-m68k.org>,
        <kernel-team@android.com>
Subject: Re: [PATCH v4 0/8] Make fw_devlink=on more forgiving
Thread-Topic: [PATCH v4 0/8] Make fw_devlink=on more forgiving
Thread-Index: AQHW/4V+vQSyjAznUkuJJWGt4Acu+Q==
Date:   Wed, 10 Feb 2021 08:19:46 +0000
Message-ID: <47ca46aa-99f3-5203-8aa7-65c6443bd965@microchip.com>
References: <20210205222644.2357303-1-saravanak@google.com>
In-Reply-To: <20210205222644.2357303-1-saravanak@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [79.115.63.147]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8621b8bd-857a-4e82-f1a3-08d8cd9ca0d4
x-ms-traffictypediagnostic: SA2PR11MB5130:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA2PR11MB5130DDA349A40CD6E5164C73F08D9@SA2PR11MB5130.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WDjx9L5k7UQGhTIK/OoZ8bjOTKvpe61oZ5Kdwnnz+EAHI+5BhRJYXLBnYw0JqE21TpKgfH3dWe+F1v4gb4mmRLwwE2I6TSmKkYNcm+HQsn0IKlqWD9g2yTy+eWb5h1Pesq2kUWKEvKPANkkF+mo5ElEStSNCSKQvOpcObGO/MSJtRBqKJA2tE9PtqikF3XDzj6WyZfLTk4LqtGZ8/SZHEtu2KVsaL9XI9Z5KpUan//d+A7tg2xNSQ+Ba8YSBB31I1Wx3Pic/0YWGnTKhRQOu8mt0BYSf32RAxghfBS83g0B6lqGUxgJFbBxP3NzpuAueqv/MskspjmLN0qFBAUKhX7Af+mpOn6FFbvxvL2CvATI9iFaBim/J5qgryjcychX/0rtAwRsfRfrNJocfLnEu+PqKBu/Honxna+88ZkLzJFKEjPd3mwyJwRnOjSpuJyLSqZEgskCfTLPwM+NREU9eemTqWxEqcVCHrncZ6Y6BtKU6N8d0NKY5SgNiRsN3YE62jPONJ19ZmqVhjrr3soAQiT4iSwe2H/vm1/Zkf7mEEsembVW26LjeM7t6PCwJgXIIJwGYuPtmFdd9Qum1XyPaZx9/7bWcph2cID8OxQg0NWdCL4GxNvUQ31snnKs+9C+F/Z8XKcsXsD4tEg+vuYB9mCHAQEaW40X+IFvLc+ttmpxvUmFt1O3CagvkypbdFdcJz4xCXtLwnOcyCxgUnPHOIQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(136003)(39850400004)(376002)(346002)(921005)(36756003)(110136005)(54906003)(478600001)(31686004)(86362001)(966005)(8676002)(8936002)(76116006)(91956017)(2616005)(316002)(83380400001)(6512007)(7416002)(5660300002)(4326008)(31696002)(26005)(186003)(66446008)(6506007)(71200400001)(66476007)(66556008)(53546011)(6486002)(2906002)(64756008)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?WWd3SGo2QVpNYkFhY2MzNW1mbVkzQmhENU9BZkpvaFFWbTBpOXdGaGEvaHZi?=
 =?utf-8?B?a0JyQmNUZzFSS0ovLzIxMW14Vm0xRVFPbzVBd01sV1ROeGJKZGIvL2F0UlNy?=
 =?utf-8?B?SmtaSklDT1ozV0FjVll1N0JEWkpwNWlzYnN3TWg1WnEvb1FiZWk4OFMrWDVa?=
 =?utf-8?B?TmpYcmd3a1R1b25hb1IweWxjWVBKRGNCQUozWGg5RDgzZFlDMmlFWE0vVUtp?=
 =?utf-8?B?RXd0K2tHMmt1VDJDQ0QvOHU0bHNhRzlrWFZZTEpPU1hTRjZzTlc4SllXNFUr?=
 =?utf-8?B?THBmWDdpNW5FbHQ3VU9PZSthVTRNU0czTEp2QmF1QmNlTHZhcGJIdkhHUnRS?=
 =?utf-8?B?WVdBUHV1NFdONU5RWS81ZWlZL2VlazF1TTVEeVNzQmRIWjJLditjNSttbStk?=
 =?utf-8?B?SWxpdmlVSXBtdi9WcFpyL0Q3OFJ2YVFmSkFxeHZXTnVNMmp3MzJ3T0RhK0JY?=
 =?utf-8?B?ZXNVdG1FWWJOcTdGVzNpRkFrYVdoTEdtajkzc2dKenJoY2ZJNUYyLzg0TnBQ?=
 =?utf-8?B?alVYY0d3bjcvVFVDNmorRnhjaU10dFUrRkZZRStSNUcxWjNaMUNOVUUrVUt3?=
 =?utf-8?B?djY4azBFV2M0WEl1cjgxTUpJK2FtMnFhVmduRGkxeGdUYTBZaEtpMTQ1TzZT?=
 =?utf-8?B?ek5RTmpXWFh6WVV1YlhITlcxYUlheU9acndPOUFyNGZOd3JpQUJ1NnlJU1V5?=
 =?utf-8?B?NkttMVBvWWgvSk5nYW04REVPRW01RjFqUWIzU1YxZ2xiT3FBelJJRmJyU0l6?=
 =?utf-8?B?Mk5qeVoySHdJZ0dBREpub3k2U1FUY0QvZjN2SkFyeno1aytrN2ZQM2tISHNC?=
 =?utf-8?B?Vy9oKzc2d2Y3bUlaK1ZyUGFiZmFkUHZ2MTNQVmFaaXpTT3VvUjJ0MWVjYW9C?=
 =?utf-8?B?R0FTMmRtN3Fqdko3dkx1bFJIeDVldnhlRW1kUmw4WDhGNVFHd1NqUXE5L3h1?=
 =?utf-8?B?OXJSNmNmMnRaSEpRTVdUL25SQlFJWDN6bG5obFAzTnBjRVpLM2tNN3FFWk81?=
 =?utf-8?B?V1d4aVlMeFJoL2dNRVFlY1g5UjVQZnhzUjJjUngvQjdhOWREbUlzZ3pOamJS?=
 =?utf-8?B?dlVlUmRPeGY4Z2RQeWlHNUdZYmw1VnA3Y3VydllNcFNBaHRqSnZDWVFUblV5?=
 =?utf-8?B?QWVtRUFzZmxsZDVEUzdHcVRZRGVTRkRPcy9KQXpRQVc1T1JTcXJma0RqazZu?=
 =?utf-8?B?am4vTVhkSXV2bGNORWRuaEdIdnNnbiszK29rS05SNGhRak5meXc5T0wrY2JQ?=
 =?utf-8?B?TzFNUHVyVjg2RTFHZldFTDgyTE1sN2JlbzF5RTRtQlhqalVTeHA2K3lUNXBN?=
 =?utf-8?B?MjkvU2VwcDg4RWpNUkkrQm90K2NsejFuL3NPYXF0OWlnYXd2Wm52YzFEQ0hJ?=
 =?utf-8?B?ZW1lZFN5RHRHSHRtZFBUam5adTR2dHMxSVhuVzBzcktObHZFN2Jvb0hCelN2?=
 =?utf-8?B?MzdzL214MmsrY2RYd3JzVnRKeUNKUCtLeWVqNEI3alNlbFZuYUx6MGkvL1pX?=
 =?utf-8?B?ME1JY1NLMllkeFc1cm81UXlHQStxWnpjbUlveWE5MXZNYXluRFUvSEVvMnBl?=
 =?utf-8?B?bGtNZUV2Q1pmUWNjV2RIUmNBUHI0YlJkNkIzMk5pSE1ubFFXLzBjMWVMcHVD?=
 =?utf-8?B?dm5Ha0FHYzZhVmpUUDZLZGVFZ3JTTU5EU3Z0ZlhrT25GUnBOcUYyYjZXSUFv?=
 =?utf-8?B?cmZkS3c5MkdkY1k2bTVGNmhTaXBWM2g4bjMzWDI4MWlROG5oaVNtYmpKaWY0?=
 =?utf-8?Q?aECRt+g1PQViVoxIs0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <16D9695A226C6341B1B43052E5CFBA1E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8621b8bd-857a-4e82-f1a3-08d8cd9ca0d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2021 08:19:46.9031
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b8GXDt2tAcbJ9ajCu8AsDh5tzpUGm1ePCSlpm80giFx/fEytloo+2oMBwWXzMt927MpHb846RIm4088hznGRwDcjaygJXqGeYouCHQgGe34=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5130
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

SGksIFNhcmF2YW5hLA0KDQpPbiAyLzYvMjEgMTI6MjYgQU0sIFNhcmF2YW5hIEthbm5hbiB3cm90
ZToNCj4gVGhlcmUgYXJlIGEgbG90IG9mIGRldmljZXMvZHJpdmVycyB3aGVyZSB0aGV5IG5ldmVy
IGhhdmUgYSBzdHJ1Y3QgZGV2aWNlDQo+IGNyZWF0ZWQgZm9yIHRoZW0gb3IgdGhlIGRyaXZlciBp
bml0aWFsaXplcyB0aGUgaGFyZHdhcmUgd2l0aG91dCBldmVyDQo+IGJpbmRpbmcgdG8gdGhlIHN0
cnVjdCBkZXZpY2UuDQo+IA0KPiBUaGlzIHNlcmllcyBpcyBpbnRlbmRlZCB0byBhdm9pZCBhbnkg
Ym9vdCByZWdyZXNzaW9ucyBkdWUgdG8gc3VjaA0KPiBkZXZpY2VzL2RyaXZlcnMgd2hlbiBmd19k
ZXZsaW5rPW9uIGFuZCBhbHNvIGFkZHJlc3MgdGhlIGhhbmRsaW5nIG9mDQo+IG9wdGlvbmFsIHN1
cHBsaWVycy4NCj4gDQo+IFBhdGNoIDEgYW5kIDIgYWRkcmVzc2VzIHRoZSBpc3N1ZSBvZiBmaXJt
d2FyZSBub2RlcyB0aGF0IGxvb2sgbGlrZQ0KPiB0aGV5J2xsIGhhdmUgc3RydWN0IGRldmljZXMg
Y3JlYXRlZCBmb3IgdGhlbSwgYnV0IHdpbGwgbmV2ZXIgYWN0dWFsbHkNCj4gaGF2ZSBzdHJ1Y3Qg
ZGV2aWNlcyBhZGRlZCBmb3IgdGhlbS4gRm9yIGV4YW1wbGUsIERUIG5vZGVzIHdpdGggYQ0KPiBj
b21wYXRpYmxlIHByb3BlcnR5IHRoYXQgZG9uJ3QgaGF2ZSBkZXZpY2VzIGFkZGVkIGZvciB0aGVt
Lg0KPiANCj4gUGF0Y2ggMyBhbmQgNCBhbGxvdyBmb3IgaGFuZGxpbmcgb3B0aW9uYWwgRFQgYmlu
ZGluZ3MuDQo+IA0KPiBQYXRjaCA1IHNldHMgdXAgYSBnZW5lcmljIEFQSSB0byBoYW5kbGUgZHJp
dmVycyB0aGF0IG5ldmVyIGJpbmQgd2l0aA0KPiB0aGVpciBkZXZpY2VzLg0KPiANCj4gUGF0Y2gg
NiB0aHJvdWdoIDggdXBkYXRlIGRpZmZlcmVudCBmcmFtZXdvcmtzIHRvIHVzZSB0aGUgbmV3IEFQ
SS4NCj4gDQo+IFRoYW5rcywNCj4gU2FyYXZhbmENCj4gDQo+IFNhcmF2YW5hIEthbm5hbiAoOCk6
DQo+ICAgZHJpdmVyIGNvcmU6IGZ3X2Rldmxpbms6IERldGVjdCBzdXBwbGllciBkZXZpY2VzIHRo
YXQgd2lsbCBuZXZlciBiZQ0KPiAgICAgYWRkZWQNCj4gICBvZjogcHJvcGVydHk6IERvbid0IGFk
ZCBsaW5rcyB0byBhYnNlbnQgc3VwcGxpZXJzDQo+ICAgZHJpdmVyIGNvcmU6IEFkZCBmd19kZXZs
aW5rLnN0cmljdCBrZXJuZWwgcGFyYW0NCj4gICBvZjogcHJvcGVydHk6IEFkZCBmd19kZXZsaW5r
IHN1cHBvcnQgZm9yIG9wdGlvbmFsIHByb3BlcnRpZXMNCj4gICBkcml2ZXIgY29yZTogZndfZGV2
bGluazogSGFuZGxlIHN1cHBsaWVycyB0aGF0IGRvbid0IHVzZSBkcml2ZXIgY29yZQ0KPiAgIGly
cWRvbWFpbjogTWFyayBmd25vZGVzIHdoZW4gdGhlaXIgaXJxZG9tYWluIGlzIGFkZGVkL3JlbW92
ZWQNCj4gICBQTTogZG9tYWluczogTWFyayBmd25vZGVzIHdoZW4gdGhlaXIgcG93ZXJkb21haW4g
aXMgYWRkZWQvcmVtb3ZlZA0KPiAgIGNsazogTWFyayBmd25vZGVzIHdoZW4gdGhlaXIgY2xvY2sg
cHJvdmlkZXIgaXMgYWRkZWQvcmVtb3ZlZA0KPiANCj4gIC4uLi9hZG1pbi1ndWlkZS9rZXJuZWwt
cGFyYW1ldGVycy50eHQgICAgICAgICB8ICA1ICsrDQo+ICBkcml2ZXJzL2Jhc2UvY29yZS5jICAg
ICAgICAgICAgICAgICAgICAgICAgICAgfCA1OCArKysrKysrKysrKysrKysrKystDQo+ICBkcml2
ZXJzL2Jhc2UvcG93ZXIvZG9tYWluLmMgICAgICAgICAgICAgICAgICAgfCAgMiArDQo+ICBkcml2
ZXJzL2Nsay9jbGsuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMyArDQo+ICBkcml2
ZXJzL29mL3Byb3BlcnR5LmMgICAgICAgICAgICAgICAgICAgICAgICAgfCAxNiArKystLQ0KPiAg
aW5jbHVkZS9saW51eC9md25vZGUuaCAgICAgICAgICAgICAgICAgICAgICAgIHwgMjAgKysrKysr
LQ0KPiAga2VybmVsL2lycS9pcnFkb21haW4uYyAgICAgICAgICAgICAgICAgICAgICAgIHwgIDIg
Kw0KPiAgNyBmaWxlcyBjaGFuZ2VkLCA5OCBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQ0K
PiANCg0KRXZlbiB3aXRoIHRoaXMgcGF0Y2ggc2V0IGFwcGxpZWQsIHNhbWE1ZDJfeHBsYWluZWQg
Y2FuIG5vdCBib290Lg0KUGF0Y2ggYXQgWzFdIG1ha2VzIHNhbWE1ZDJfeHBsYWluZWQgYm9vdCBh
Z2Fpbi4gU3RlcGhlbiBhcHBsaWVkIGl0DQp0byBjbGstbmV4dC4NCg0KQ2hlZXJzLA0KdGENCg0K
WzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAyMTAyMDMxNTQzMzIuNDcwNTg3LTEt
dHVkb3IuYW1iYXJ1c0BtaWNyb2NoaXAuY29tLw0K
