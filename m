Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9F39369951
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Apr 2021 20:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243533AbhDWSXy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 23 Apr 2021 14:23:54 -0400
Received: from mga05.intel.com ([192.55.52.43]:10021 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231400AbhDWSXx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 23 Apr 2021 14:23:53 -0400
IronPort-SDR: n4jmYCFfC+auwngduqW6D+VU52U/3tdBcO4divCzY1opzOZ7m7ovgBjG0BahWqfA6mo7y3hLeX
 vCApeCyDoqmA==
X-IronPort-AV: E=McAfee;i="6200,9189,9963"; a="281441567"
X-IronPort-AV: E=Sophos;i="5.82,246,1613462400"; 
   d="scan'208";a="281441567"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2021 11:23:16 -0700
IronPort-SDR: 66+fBc2DIaMquscnsYXJMNmycqxZI6cto3IhqlWB3lcw6E9sOWwDMA3rmyEF0chBWLzZCF3UGy
 DnAs1GXNKPRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,246,1613462400"; 
   d="scan'208";a="386457849"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 23 Apr 2021 11:23:16 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 23 Apr 2021 11:23:15 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Fri, 23 Apr 2021 11:23:15 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Fri, 23 Apr 2021 11:23:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Je5YQKe4EFsgSpzl+Ql1Ai/RV7nS+2RFD6xU3DqimLRdj+cDZ0LiJxlBHQCiyk+7/Ghurwi7xV7JrSddBFgytQbShRPZ8t+1CHKLtNrEmPGL628xuYURHyV043uds4NtPwFI0siCC1M9fqs5DtLt+Gg1piQhescEpzuntnQgzgBBohWB4lUP+aH2wutvJYmboCFY+CoRlvobXe1CO7sUI22ky9zoiFrGDPcKDv8TyMpRPCuQ2IAE16vNUqoFTpot4vX5F/O5ghETVH8nalzgYLpzdyi4aKjsF8has68FS1Mv8x/bu2SeyoDMl56eyGlUIQf69DhD3trxMgNrNCNTcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pgaVMJK1YN9S4PQYO8mcuVFn8StndmY6hCvQO/ZNm6M=;
 b=TMk2NP8R5LDHF6ZiBlKsBkcVgplJdZIfnQUjoPsn/dAeTleI+LxCcx0CwL3pseGrZ4PL23FgS5+qR+AGVTG3f5ianqj7Iqq+QSZJq6cTpYlzVDPvCmgxsFPMiL/QkJ+6m8WNqHve9zDEHZ7aYV+CV/wdEQnVQB3rWn3eMhpmtgGGSFgA8+f4Deb8XOi9Ahzhk4XvRlybEi9WD1rZSZEcg06EEy+exm1UbXKiFYPYoVkxn2YP9DHpUbIvUxK6LtUxiXALrq7QXHeerZYWzhhEPFFoz3cZa5+QDSxr8k+lYgERSgnw56CACbf+WarQMt87N8qN0qETK/EIe2GioKUhZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pgaVMJK1YN9S4PQYO8mcuVFn8StndmY6hCvQO/ZNm6M=;
 b=ERLnjzzX9cofLSNZR1iYNXmby/DEoKGequ2oTOYF2R/Y03KDFAakjqQlo0EoTtE2GtRdpRIuRApOiXsT5tXElkLy+dr+JWad1exvuYt9eAiOoKEiQGdjeRxh33kp9Hhnrqk0vAFt54P92hL5+GuW7rh1hjpH8gsPOdo2oPK0uV0=
Received: from MWHPR11MB1599.namprd11.prod.outlook.com (2603:10b6:301:e::16)
 by MWHPR11MB1245.namprd11.prod.outlook.com (2603:10b6:300:28::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Fri, 23 Apr
 2021 18:23:14 +0000
Received: from MWHPR11MB1599.namprd11.prod.outlook.com
 ([fe80::48df:6af5:afe:ea7e]) by MWHPR11MB1599.namprd11.prod.outlook.com
 ([fe80::48df:6af5:afe:ea7e%7]) with mapi id 15.20.4065.024; Fri, 23 Apr 2021
 18:23:14 +0000
From:   "Kaneda, Erik" <erik.kaneda@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
CC:     Rafael J Wysocki <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Len Brown <lenb@kernel.org>,
        "Moore, Robert" <robert.moore@intel.com>,
        "ACPI Devel Maling List" <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: RE: [PATCH v2 1/3] ACPICA: ACPI 6.4: MADT: add Multiprocessor Wakeup
 Mailbox Structure
Thread-Topic: [PATCH v2 1/3] ACPICA: ACPI 6.4: MADT: add Multiprocessor Wakeup
 Mailbox Structure
Thread-Index: AQHXN8EabpTlyZf2/06o7s8uH+np1qrCClSAgABc8qA=
Date:   Fri, 23 Apr 2021 18:23:14 +0000
Message-ID: <MWHPR11MB159915FB3E483563BADE104AF0459@MWHPR11MB1599.namprd11.prod.outlook.com>
References: <20210422214708.716164-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210422214708.716164-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAJZ5v0itaKL58ieMB6ER47GVns7Ukvd_7VNBAxkktWB5cDv-SQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0itaKL58ieMB6ER47GVns7Ukvd_7VNBAxkktWB5cDv-SQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [174.25.99.223]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fd6b071d-2e9a-4a90-a8f9-08d90684dc03
x-ms-traffictypediagnostic: MWHPR11MB1245:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB1245226536F6E0F2C86DF08EF0459@MWHPR11MB1245.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o0L3bOSMF+Ppod9Dk91IWAQKwYoTCiZc1ZtprRIsfblycJy9buYpIok9rznMIkJpUJ/Hqykrxs0rBcS8Bg6ZZ///ahVXP63VRG9gWkMOPkndF34Pv236mLTh7uR4yFyETsqY3JFxSvrvUeSYuNUYwJ7xvqeO+1s1HWMa82AM7ETtWAn4BEpuzZk/RKj9GEdzQ37qpxodQ7Hj0Nter6UP5Ee1ylkBTUSZwWip9oGZbJIyY7qsD3GBFztDwMC0OFCi6pILEVfVYOQeTkQe8+HveUSN445MuwdDDIHSaIj9y7aYwJeMNEvhX6igQiAaK0OHUMUlcj0Q18aacnEAfcrjXQ03/Gj+wK0sJIYHlhP9PGnAj1u42GTXdXiGVXiJv48oQWfBAVbCEcLTzs7ILvS4XNgg+ibDJgB9IYbjSOTeznl2CyMVumI2HvJzO91PfDqfcnJfh5iihzTTehcvwWSrIfrQGXxSxHSoNj+L6vPPJcAcGF/0G+beiyR7ftmcmQZDBwMtdvkPJkwPr0p/7NurWkiTi8BiuqaRHNbiBDz0a1DU6ymbtqMxj5dhA28z0/Ixc4HXP4O+j7ozXNV2MD1CyoBPpakseI1OfkkzxVYrWdDhSE9a8FqURBIyS5sctVyCMI8WjvJq0l+cRTuG0Qd5FdKhNoXvyqMLi99K7b/ifAykTgYv+k7k1G/wG2Oioqq+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1599.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(376002)(39860400002)(136003)(396003)(53546011)(966005)(8936002)(8676002)(83380400001)(478600001)(6506007)(7696005)(86362001)(110136005)(9686003)(76116006)(15650500001)(7416002)(52536014)(33656002)(64756008)(2906002)(66476007)(66556008)(55016002)(66446008)(4326008)(66946007)(71200400001)(122000001)(5660300002)(186003)(316002)(38100700002)(54906003)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?WnZKYjkxWTlyQmEveHFLNmlTUDZrNEY2WVc4ckFNd1drTDB6dzBNbDNVWXlV?=
 =?utf-8?B?RE9mQVVjSjkwcFQ4djRvOXFudk03NWJQQnFmaEpZN3dFdnVUd1FyUXRHYiti?=
 =?utf-8?B?dFgxU3d6cDRlTDJFSVpOZjFIZnUydUg1OGxMWWRtM25KZjJCTS9uc2pNM1M2?=
 =?utf-8?B?YjdXZWNkVVdFalNBdGZwOE8vQS9VUmswTlJYbVM4TW45ZlBFd2ZLRDlLbGRO?=
 =?utf-8?B?TTJqYjd4OUpGK25MemdWMXYrVW9CVnBDVFNMSGdIMDJia1BMV0dZd212WmFu?=
 =?utf-8?B?RlBzU3lPak81NXhoN3kxQ2F3SFI3ZjZpTmtZN1pvOEgwU0FOQVZlV3h2MTNM?=
 =?utf-8?B?eDdqNmdnNVJGVWFpQWNqOHFqZ0F6bktINFB2aXUybTcrdmxXUm1mOE8rY0Fv?=
 =?utf-8?B?RlRXdUhVMVltMlczTUs0OTFTTnJSSFlYVTdnOFJUNER2WC8vRjhiQmlyUVd1?=
 =?utf-8?B?aXJpZFlYNUU0dk45SCtjWUpZOUNySzFSQVZOY2sxelJsZnlvOEtldHc0WEFK?=
 =?utf-8?B?eVlLUm5PUVdDOHNuL2lFWm1WM3FrSklGejRPQi90WFBsYkU1R3ZoMTFFRG5Z?=
 =?utf-8?B?QVVnZzdxSGpCcEE1eXl2aEl3bjVQNlBHOHR4NVpMbTI3Q0I2cmhCYVpNTTNR?=
 =?utf-8?B?K1hKZ1pMYjkwd1RZd3FZc1VEZTlVa0dxOHg2dmFpWVJNQXgyc1NyN2YwaEZy?=
 =?utf-8?B?Sk1qUTlhL0h5QkZ0THozMzFZMGZZcExvRDJObmFHUTZpbEw5bVU1cm9aV3Vr?=
 =?utf-8?B?SW15SXRRdGh3SzFlRkY1TTE3NDlhZEM0dDFsNnVKWUkyZlE5TmJjUnpXK0Vz?=
 =?utf-8?B?MjlPaFJNeEJWaWdlSFkzb0U1aUtpVXZQdzU4aGxybUgyUlpMVGgwR1Z5aEVh?=
 =?utf-8?B?SXBtb0VqTlVTTUwvWVBDRDJQSWtya3I2VDRaYkxnRVM5TU5wMVFqbWFKSFUz?=
 =?utf-8?B?RUhUTXFTRzhLc1ZPeHY5NzJRaU95cDBqaXp3TGk2M0tNMXhNZVBXdnl6SlA1?=
 =?utf-8?B?T25qZ294L3A0YnRZeVo3VDR0VDV0T1h2SitKRVF1K3pNa1dVUWF5RDVxZEs5?=
 =?utf-8?B?d0p6MzRkblQ0RWZ0aEx5Ly9tRGdGT0ZQekwrR0dsTWh5Z3VYWG1VWUtOUkcz?=
 =?utf-8?B?VVFMUUFUbENidHJTN0hUTWVTL0I0T1Nnajk0Slprb29VRm9kS3VDd0tCeHpG?=
 =?utf-8?B?NklQdHdEclJjaktBRDk5Q29nUEJ5TmVlZGMwdkVoVFFBT0p1Tk5LNDdoUHQ1?=
 =?utf-8?B?aFo3N2I0N0hpd0k1amd5QWt5UTUwKzFabHRONzNvdjkxWkk5Y0lBay9XaTJi?=
 =?utf-8?B?ZGp0VTJDQ1BTNkFqbjFCK3FINmEzWnFIcHJsaFUxUGtiRlBOSkJoSi9NQTY0?=
 =?utf-8?B?SGlUZjZ2OUtJVXNXZHlRbGVpcWw2MDYrbGZ4TjlUYmRZUFBNN2NtZys3VDRV?=
 =?utf-8?B?ZjVRbktKLzZUYytlZ2VqMXF6MlZaelBGL1JLZVkzamY0cXA2cWozdmNsc0Nq?=
 =?utf-8?B?SVoydVZmZEZlUm94OEY4YWpHeGxuRHZHcC9uNUZFS2REM3BoMmsvVUg0ZzRo?=
 =?utf-8?B?VThXTVBhYWI3VG9nZ0ZrR1NZZEdMWDdaamJxUDdhWEdKMk05VTNpdi9VTXZu?=
 =?utf-8?B?Vm9WamtYQ2g4ZWtkSXFsbnpwWmdDRkVSbU5NZkxOdktJdDgzcmMrQXppdFRk?=
 =?utf-8?B?RFlqMktmbkJNQTBCMk9YZkhGMkJTWmhOQjVpKzdtZWh3ZXJtTDdLOU14bzhk?=
 =?utf-8?Q?hhMxt8TVMia6u2OvohNLeanri7p5ESvZekD1sNo?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1599.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd6b071d-2e9a-4a90-a8f9-08d90684dc03
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2021 18:23:14.5503
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xLgnkJq1W5u8RLXp72bDyG0PkW5csqHeG8zl9mGWLlKMbPYjz4yIJGPLQafQAU+SNtbH+ryuu8T/mzDuVPvLYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1245
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUmFmYWVsIEouIFd5c29j
a2kgPHJhZmFlbEBrZXJuZWwub3JnPg0KPiBTZW50OiBGcmlkYXksIEFwcmlsIDIzLCAyMDIxIDU6
MzQgQU0NCj4gVG86IEt1cHB1c3dhbXkgU2F0aHlhbmFyYXlhbmFuDQo+IDxzYXRoeWFuYXJheWFu
YW4ua3VwcHVzd2FteUBsaW51eC5pbnRlbC5jb20+OyBLYW5lZGEsIEVyaWsNCj4gPGVyaWsua2Fu
ZWRhQGludGVsLmNvbT4NCj4gQ2M6IFJhZmFlbCBKIFd5c29ja2kgPHJqd0Byand5c29ja2kubmV0
PjsgVGhvbWFzIEdsZWl4bmVyDQo+IDx0Z2x4QGxpbnV0cm9uaXguZGU+OyBJbmdvIE1vbG5hciA8
bWluZ29AcmVkaGF0LmNvbT47IEggLiBQZXRlciBBbnZpbg0KPiA8aHBhQHp5dG9yLmNvbT47IFBl
dGVyIFppamxzdHJhIDxwZXRlcnpAaW5mcmFkZWFkLm9yZz47IExlbiBCcm93bg0KPiA8bGVuYkBr
ZXJuZWwub3JnPjsgTW9vcmUsIFJvYmVydCA8cm9iZXJ0Lm1vb3JlQGludGVsLmNvbT47IEFDUEkg
RGV2ZWwNCj4gTWFsaW5nIExpc3QgPGxpbnV4LWFjcGlAdmdlci5rZXJuZWwub3JnPjsgb3BlbiBs
aXN0OkFDUEkgQ09NUE9ORU5UDQo+IEFSQ0hJVEVDVFVSRSAoQUNQSUNBKSA8ZGV2ZWxAYWNwaWNh
Lm9yZz47IExpbnV4IEtlcm5lbCBNYWlsaW5nIExpc3QNCj4gPGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc+OyB0aGUgYXJjaC94ODYgbWFpbnRhaW5lcnMNCj4gPHg4NkBrZXJuZWwub3JnPg0K
PiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDEvM10gQUNQSUNBOiBBQ1BJIDYuNDogTUFEVDogYWRk
IE11bHRpcHJvY2Vzc29yDQo+IFdha2V1cCBNYWlsYm94IFN0cnVjdHVyZQ0KPiANCj4gT24gVGh1
LCBBcHIgMjIsIDIwMjEgYXQgMTE6NDcgUE0gS3VwcHVzd2FteSBTYXRoeWFuYXJheWFuYW4NCj4g
PHNhdGh5YW5hcmF5YW5hbi5rdXBwdXN3YW15QGxpbnV4LmludGVsLmNvbT4gd3JvdGU6DQo+ID4N
Cj4gPiBBQ1BJQ0EgY29tbWl0IGYxZWUwNDIwN2EyMTJmNmM1MTk0NDFlN2UyNTM5NzY0OWViYzRj
ZWENCj4gPg0KPiA+IEFkZCBNdWx0aXByb2Nlc3NvciBXYWtldXAgTWFpbGJveCBTdHJ1Y3R1cmUg
ZGVmaW5pdGlvbi4gSXQgaXMgdXNlZnVsDQo+ID4gaW4gcGFyc2luZyBNQURUIFdha2UgdGFibGUu
DQo+ID4NCj4gPiBMaW5rOiBodHRwczovL2dpdGh1Yi5jb20vYWNwaWNhL2FjcGljYS9jb21taXQv
ZjFlZTA0MjANCj4gPiBTaWduZWQtb2ZmLWJ5OiBLdXBwdXN3YW15IFNhdGh5YW5hcmF5YW5hbg0K
PiA8c2F0aHlhbmFyYXlhbmFuLmt1cHB1c3dhbXlAbGludXguaW50ZWwuY29tPg0KPiANCj4gSSdt
IGV4cGVjdGluZyB0byByZWNlaXZlIHRoaXMgcGF0Y2ggZnJvbSBFcmlrIGF0IG9uZSBwb2ludCwg
c28gSSdtDQo+IGd1ZXNzaW5nIHRoYXQgaXQncyBiZWVuIGFkZGVkIHRvIHRoaXMgc2VyaWVzIGZv
ciByZWZlcmVuY2UuDQoNCkhpIFJhZmFlbCwNCg0KVGhpcyBwYXRjaCBoYXMgYmVlbiBMaW51eC1p
emVkIHNvIHRoYXQgeW91IGNhbiB0YWtlIHRoaXMgYW5kIHRoZSBTVktMIHBhdGNoLiBJIHdhcyB0
b2xkIHRoYXQgdGhpcyB3YXMgdXJnZW50IGZvciB0aGlzIG1lcmdlIHdpbmRvdy4gU2luY2UgdGhl
eSB3ZXJlIHNpbXBsZSwgSSB0aG91Z2h0IGl0IHdvdWxkIGJlIGVhc2llciB0byBoYXZlIFNhdGh5
YSBzdWJtaXQgdG8gTGludXggYW5kIEFDUElDQSB1cHN0cmVhbSBzZXBhcmF0ZWx5LiBHb2luZyB0
aHJvdWdoIHRoaXMgcHJvY2VzcyBtYWRlIHRoaW5ncyBhIGxpdHRsZSBtb3JlIGRpZmZpY3VsdCBz
byBJJ2xsIGJlIHN1cmUgdG8gY29tbXVuaWNhdGUgd2l0aCB5b3UgYWhlYWQgb2YgdGltZSBpZiBJ
IGRvIHRoaXMgYWdhaW4uDQoNCkVyaWsNCj4gDQo+ID4gLS0tDQo+ID4gIGluY2x1ZGUvYWNwaS9h
Y3RibDIuaCB8IDE0ICsrKysrKysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNl
cnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9hY3BpL2FjdGJsMi5oIGIv
aW5jbHVkZS9hY3BpL2FjdGJsMi5oDQo+ID4gaW5kZXggYjIzNjI2MDBiOWZmLi43ZGNlNDIyZjYx
MTkgMTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9hY3BpL2FjdGJsMi5oDQo+ID4gKysrIGIvaW5j
bHVkZS9hY3BpL2FjdGJsMi5oDQo+ID4gQEAgLTczMyw2ICs3MzMsMjAgQEAgc3RydWN0IGFjcGlf
bWFkdF9tdWx0aXByb2Nfd2FrZXVwIHsNCj4gPiAgICAgICAgIHU2NCBiYXNlX2FkZHJlc3M7DQo+
ID4gIH07DQo+ID4NCj4gPiArI2RlZmluZSBBQ1BJX01VTFRJUFJPQ19XQUtFVVBfTUJfT1NfU0la
RSAgICAgICAyMDMyDQo+ID4gKyNkZWZpbmUgQUNQSV9NVUxUSVBST0NfV0FLRVVQX01CX0ZJUk1X
QVJFX1NJWkUgMjA0OA0KPiA+ICsNCj4gPiArc3RydWN0IGFjcGlfbWFkdF9tdWx0aXByb2Nfd2Fr
ZXVwX21haWxib3ggew0KPiA+ICsgICAgICAgdTE2IGNvbW1hbmQ7DQo+ID4gKyAgICAgICB1MTYg
cmVzZXJ2ZWQ7ICAgICAgICAgICAvKiByZXNlcnZlZCAtIG11c3QgYmUgemVybyAqLw0KPiA+ICsg
ICAgICAgdTMyIGFwaWNfaWQ7DQo+ID4gKyAgICAgICB1NjQgd2FrZXVwX3ZlY3RvcjsNCj4gPiAr
ICAgICAgIHU4IHJlc2VydmVkX29zW0FDUElfTVVMVElQUk9DX1dBS0VVUF9NQl9PU19TSVpFXTsg
ICAgICAgLyoNCj4gcmVzZXJ2ZWQgZm9yIE9TIHVzZSAqLw0KPiA+ICsgICAgICAgdTgNCj4gcmVz
ZXJ2ZWRfZmlybXdhcmVbQUNQSV9NVUxUSVBST0NfV0FLRVVQX01CX0ZJUk1XQVJFX1NJWkVdOyAg
IC8qDQo+IHJlc2VydmVkIGZvciBmaXJtd2FyZSB1c2UgKi8NCj4gPiArfTsNCj4gPiArDQo+ID4g
KyNkZWZpbmUgQUNQSV9NUF9XQUtFX0NPTU1BTkRfV0FLRVVQICAgIDENCj4gPiArDQo+ID4gIC8q
DQo+ID4gICAqIENvbW1vbiBmbGFncyBmaWVsZHMgZm9yIE1BRFQgc3VidGFibGVzDQo+ID4gICAq
Lw0KPiA+IC0tDQo+ID4gMi4yNS4xDQo+ID4NCg==
