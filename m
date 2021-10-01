Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 817FF41F2F3
	for <lists+linux-acpi@lfdr.de>; Fri,  1 Oct 2021 19:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354751AbhJARVq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 1 Oct 2021 13:21:46 -0400
Received: from mga01.intel.com ([192.55.52.88]:37724 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354507AbhJARVm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 1 Oct 2021 13:21:42 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10124"; a="248068364"
X-IronPort-AV: E=Sophos;i="5.85,339,1624345200"; 
   d="scan'208";a="248068364"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2021 10:19:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,339,1624345200"; 
   d="scan'208";a="710044353"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga005.fm.intel.com with ESMTP; 01 Oct 2021 10:19:57 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 1 Oct 2021 10:19:57 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Fri, 1 Oct 2021 10:19:57 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.177)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Fri, 1 Oct 2021 10:19:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ljmkC7xjTYaso8uVXwANqbgz6SfzhyhR+a6Q0bMS/sCZKNcfhs1eTyprPgGUTn0Wd3Tg/xLntGdjUMsALXJ7NASxRC39z8+rvuQPsdfrjs5xKnaf4FreH6VzQi7ZhM+xZW4EzgMK2XSJuwddbLivCjLKNR8MrXwlleCFbEBu0nUUbw7lwYj5uBlkbRC/bugAOC4KAMREZUA2s0oxDC/SktkFxGEx1TvSagdQE1rmSQ9rF8PjXBdeMvx+iQf/s4uIvAwipFsr4zYQJY8LoqxYhyHwooZ/OjdarJeTGprx+USqbcx7RtL/cAjj+PLSHFxKFdckK8e1/kZSXmgcypG/gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mYPmFtBMv2fYWx+9+7kWVtrnriqP7Xih7ObjBUus26o=;
 b=gDQI52/xa9g/pHaAkzShXxLzPexfVES2sehxiVAcERFv+tlOzEYfpYlMai7SzGgifkn/tVrAUG1cBaEreAaIjTQ/RqtGCNHtv5e1yAME4SG9XNOBvBoyQXTVg/ZsOcidYETyzJay3UE3cCrSPgu34KKIowCkpRr6GxD/fcaFQkOS0CKmG8K4RCsDmZ+zGoq6KlsifLV2S5NcHNT77pjpE0gIb/tN11CGRbN+j90YOGYBOCRVa5SPRFiWuag0O+Kn3wQrh0IMIUCGFqSET2/Ul3X1SFP9SnAJa7rmWd0xyS4FoRG/+0o/UI5bPvg5kxGgZIFgmyN2ePifzuPjSg/YJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mYPmFtBMv2fYWx+9+7kWVtrnriqP7Xih7ObjBUus26o=;
 b=hC2ZySqpm8qZakDUI/cd6WoCXc4oQAx9dZY4Rzv1R5bFD3vbVd0XopiqPXSbdpzg6eZKKZ3woba5NxL/cQDTyjAIP2KJp5z5N47aeViKUdHC/aW6E3xIjDOrpSBsdEy6FMtJC2TvxxmgT4TYUIKLLENX7H/XqfUEFrQQHoLvAVo=
Received: from BN6PR11MB1571.namprd11.prod.outlook.com (2603:10b6:405:d::22)
 by BN9PR11MB5481.namprd11.prod.outlook.com (2603:10b6:408:102::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.19; Fri, 1 Oct
 2021 17:19:55 +0000
Received: from BN6PR11MB1571.namprd11.prod.outlook.com
 ([fe80::4954:17db:487f:4fb1]) by BN6PR11MB1571.namprd11.prod.outlook.com
 ([fe80::4954:17db:487f:4fb1%6]) with mapi id 15.20.4566.019; Fri, 1 Oct 2021
 17:19:54 +0000
From:   "Brown, Len" <len.brown@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: RE: [PATCH] ACPI: Update information in MAINTAINERS
Thread-Topic: [PATCH] ACPI: Update information in MAINTAINERS
Thread-Index: AQHXtuhVncX5Y7iCXUGeyx1uLfaW5Ku+YxjQ
Date:   Fri, 1 Oct 2021 17:19:54 +0000
Message-ID: <BN6PR11MB157113C8E8A39FC26460377FE0AB9@BN6PR11MB1571.namprd11.prod.outlook.com>
References: <5776239.lOV4Wx5bFT@kreacher>
In-Reply-To: <5776239.lOV4Wx5bFT@kreacher>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.200.16
dlp-reaction: no-action
dlp-product: dlpe-windows
authentication-results: rjwysocki.net; dkim=none (message not signed)
 header.d=none;rjwysocki.net; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b2e2322a-4f81-4261-1db4-08d984ffafbd
x-ms-traffictypediagnostic: BN9PR11MB5481:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR11MB54812B818C551F37ECF2A7E9E0AB9@BN9PR11MB5481.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Zrkui+8Z3je9+Vx7Y84hLr+eTSEwXabpIgbq+deEMaa9FaP1dQFXR2X/kkSq0lbgjw2oE1fkdgZtg15bFkidni/g2hpF+oeZxcSSZL3E6DhFz21bz0QgvmQc/FCXFYd6pMGsbU1ZBEuCB5TFCqAATljhU2aRTMLrD0mtLxnK9uzlX5IlP+S68ncr8X6RM72uUbtn3JmYMxt4KXbzuYuEOyDzYyV4hG9IWMIZv69qhasBRnibnkjnif1TJVKebHhyDaeWuBAPsSmYFL59Xf/WCdNDB7qE5+aG5kdEPoA2jl3v8QWkMq5OP/gqP2VNsLok27g/5vp0JiHcgiyQ6gDCZt8bCdUebBmRYXUyIxl/u13/kszjuZt8o5H0o9IVL9EgIbjBdH31s10pDQJI3CmBlINIrqAXBx1O2B1rGhwzA42y4eQH3v3r/SkAIUZ7nREpXM96c5o3uoJCc53GO+KMRKnFKDrxraZL6ZwjHesiFQ4djfWYPz1fl9Fm0jcXRLxvCpQR0EwPS9rA7LNdP+0uV5O4BWUCYBmR2BAfSsDzgiR6824w1mxbhUl1ObffZGIDUSixu3VD7YnVoytnFQf+phgfCOwbYG/VeVo98/1ZsYaHtB3dQL5gHiSxpe+iP1I5zCC3B7izcYEjeXwZ9KXICJNzs71T6hxEAatX1aCp+J1ce1tpcIgBNCiT+GG4IueAUpDtIgh7275mGoVUvXlamg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1571.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(186003)(66476007)(66946007)(66446008)(76116006)(26005)(52536014)(66556008)(64756008)(7696005)(9686003)(55016002)(6506007)(2906002)(8676002)(558084003)(33656002)(5660300002)(38070700005)(38100700002)(122000001)(8936002)(4326008)(316002)(110136005)(86362001)(54906003)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L1E4eTJYT2JtWUV4bHBVQ3NjeWFBMjAzMnJDdkE4MzBvWGFqL0lyV2FJcW4y?=
 =?utf-8?B?VnBPR3VjbTJ4ZTdOYUNxR2s4YUJIREZKVjV2YTJKa2N0SVUxZENkNDZ4Rjdn?=
 =?utf-8?B?Qjc4QThmSFRSUStHZ3ZjWkFzMldBTEMzcVI2VVFvQ2R2Qmd0bzdvQVNjbllh?=
 =?utf-8?B?MU9wZjNNNGtqVU1tbnhaclFoYW1lcDZlUXdERGhXbGVDYWVQQnJHa2RJUlBS?=
 =?utf-8?B?NjJDNWlOY0lOenhuY2loclNITzFsM1NMSFlIblc0UVZJU1VEVk9ENjdRd1FC?=
 =?utf-8?B?dWVvdkNBTkV1SUNzTGtBOXg1ekN5d2NOQXlxVkRKZSs2c0cvc1VRYy8rcDVR?=
 =?utf-8?B?NGIwQTk5d0dEWU5GTm1Wd3BENkJYMUFSOCt4VlBlV09WU2lMQ0JmYjFyYUZI?=
 =?utf-8?B?TE9VNkZ5bkRoNFozd29SUi8vMXpTTk1DODFnanM2cUxYUlJRVlc3cklnY3BL?=
 =?utf-8?B?R0hSTXd3dlJLVnRySS9KcEJRdGsvVHQwd0hDRmpKZit2Q3d2UENuN1dKRHN0?=
 =?utf-8?B?ZmxMSHorZk9oakxFdE9GSnpOdFpMeUtlZEdYZnQvN2kwNFpCQU9LSHdXb3J2?=
 =?utf-8?B?eHlTWC8vV0ZESERwVHdGUTJaMnMrL21mMkRWYmxORFh3clBBTCszaXdYSmRI?=
 =?utf-8?B?bGhkQk5FSTdQUDRSa3YxWWplM01UcEk4TkY5VDgrbWpQM1ZacGhOVzhyVXJW?=
 =?utf-8?B?V2tnSHRCTHZ6ZzZ5aWU3L1E0T0dMWStDWHlqcTFXb3hhMzRUQ0FTL3lDM1F5?=
 =?utf-8?B?dE5rZzBkc1JQeVpsd1dUYjNlREJKdjFDN2FyTGNuZzBJeWJvcVNXWVdOZVo3?=
 =?utf-8?B?RUQyNkZOV3VsTmNFT1JaQUUwYjNNdHA2Ylk0eFBJcnNxSDJiOGFyakMyeC9z?=
 =?utf-8?B?dFNRazNvOEFKZVlGSUtjSHE3L1FBSTgxZVArWFNkRm93akhLQWtIUGY4MmNE?=
 =?utf-8?B?TkhFTHRqSTlWR3ppb1gyTTcvYTl4a3NyZUdlQXcydVlNbm1vK0p3RGt6Q3RQ?=
 =?utf-8?B?VlNHZFd2cTZqNHpnVm9NUFRWM29xcktCQy9tRzIzSkdpZWY0bk5aVWl0Mm1q?=
 =?utf-8?B?dGE0S205dzQrUVNYVWo1UFp1N1YwS3BvQnFDbm5mZXRUbDZZSUhJNmhmRU1t?=
 =?utf-8?B?eWNhcnlUVEZ0MnRQWU5yZUowaG9oeFpldTl2eHh4bkVueXVsR3FYUisyTGJj?=
 =?utf-8?B?ODlJNzZWdXFxS3RXL3lVbW8wTk5sdWRMRDFjaEY1KzlVUXRON2c3ZHRudjhn?=
 =?utf-8?B?WHVhYWJIYktxVlJiaGQwZUUvZ2tsSlVVUEwwdFQ0VzEra3pEdkxWRDBJNVdV?=
 =?utf-8?B?c2FLMEVCRGJJdldtVjYrQ216MUFaRUxPU29IZWRkazhTUzQ1QnplZzNWcytP?=
 =?utf-8?B?UG9kODBqQndVYkFNRURQZEtTTjZ5TVRiTXNYL01nVk9BTm1VdXJEQ1lFVE1W?=
 =?utf-8?B?MEpLZ1F0NGVaNmgwQmdIdU4yaDl0aWFhQVR5eFc4dFE3MTBDcEZJRTFqVGNB?=
 =?utf-8?B?RVBWNUNMNm9FekpZVFFNN2ZlV2xHSUFZRmpFY0hhdDdHZlFyTFV3SnYyZFg4?=
 =?utf-8?B?Ym4ySXdoeng2MHdRUmhpMGk3eWR1eHdKOExNQUJ3b1FCWUduRXltR3RNaExq?=
 =?utf-8?B?RWcrSE9tTEJ3T3lqQ0JDeFBNTWNJeVdJS0F2ckR1Z0RJZlJFTWhXdzJYYVdr?=
 =?utf-8?B?OUQwM29WQ0dneEYzc1pZK3BWUGxmdGZCRjZzcWpTU2twMmdhSG5YZmMwYXhu?=
 =?utf-8?Q?aWZhtLcwhSn0VvRJ+h8Hdktvs6w7LZfbAEWB2T1?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1571.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2e2322a-4f81-4261-1db4-08d984ffafbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2021 17:19:54.7780
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vkR45Jh4KAtgGBC3oNIE01Su80Rf/NfO9Q+OWmDFLbScKb2zjq58p+Mxi+y83Cfs4MFQfsZPDkYaAWKu49YECg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5481
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

PiArUjoJTGVuIEJyb3duIDxsZW5iQGtlcm5lbC5vcmc+DQoNClJldmlld2VkLWJ5OiBMZW4gQnJv
d24gPGxlbi5icm93bkBpbnRlbC5jb20+DQoNCvCfmIoNCg0K
