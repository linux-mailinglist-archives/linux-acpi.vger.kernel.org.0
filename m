Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC034E9F5F
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Mar 2022 21:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245428AbiC1TFv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 28 Mar 2022 15:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245434AbiC1TFt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 28 Mar 2022 15:05:49 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A9727148;
        Mon, 28 Mar 2022 12:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648494247; x=1680030247;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=bBUPeuYWpcncOCPyveGhhQjzSbpo11rH43zBVpyQSl8=;
  b=UHkEijCY0hRIAOR7rCcjedcdZAsr7PNx24P9GrLTiPPb86+9nCffFZoF
   lewcLB35M2Udk0GBuV/FxOyu5V1Y90ctIudq0caBrqCpy3d3FB8o+Lt9I
   B+8D9RjWp0EicIzA5xYe9635M9OpMFk+p5rpS5xzU3WJMjTLke8WiwNgo
   aXqMu2UjjlxK0nd4jMdgzqMNbsYwHIzF6itThmTXrtI2dXd9aV4h1/VpT
   SbV9cgQvy49BkbY/3RJt6iLnPAGABCe39/6OGScOYhwmIab/dID1sCF1k
   LSu0vUTO2fLfgaWRKdUs641GBXl/SMeODzKpP8HhQjJmptrnQhiPcqw5z
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10300"; a="239015646"
X-IronPort-AV: E=Sophos;i="5.90,218,1643702400"; 
   d="scan'208";a="239015646"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 12:04:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,218,1643702400"; 
   d="scan'208";a="787331532"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 28 Mar 2022 12:04:07 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 28 Mar 2022 12:04:07 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 28 Mar 2022 12:04:06 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 28 Mar 2022 12:04:06 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.176)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Mon, 28 Mar 2022 12:04:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bDX0xwB5A12eOEpiUkyOPk6FBzsuv5EmDzeH+t0TacoxKrDl8yGjLWmLmMAVmW4mWkhL7w5nWJBt3d2KrpN9tDZxsp5Vnt1u+9olrfusdha4st0IfhmVeHIt9GJ1ieGpg8H9ZEaSZmivn8i41hRF2E4OvEJejQoZSGmzqrJHPRg3wkme1IeUH404rtY3AvMRLrmKKAY3q+g1KvOKMObmsi9n4zhyIbUUzNkaG7nGBDd12jrhgnvUsxl18P0oLrJOvg6vVUGK/H8alFzcn0rk82zo3OWGalRX2/pmsMcGbqzOpBw+kvynJJd+lfcWY4Jop7sIFYvHLNakGcfITynH9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bBUPeuYWpcncOCPyveGhhQjzSbpo11rH43zBVpyQSl8=;
 b=Em996c+lqjYmAkZwee0VW1xIQVaaHCoI+ejMiy0xu9764AHqjMpojwSgVHLrD39bhFGBCh0pHlIvjrjVLNCDIoJW6slfN9/Y0rvd7cEZaAxocI6DvYbNivAnjMm3fuBFCcNFGPc61hbYL+ZjAgnml5zwOtvRYw97H77I8QEn+6Zjeg2GVlV19fQzcqk6bfxZBXh75ERQ2f77I9nbFyP/yejfz6jmljgWRwtX4+zzTsiKvHvxhIvR0Izl6dQfPMSriJoc13aPjNJwLpxGNruer7wl506SjUZjBH2RRfeQJUTL18Kn+1Y2SDQ4tDbdgjkDDtO4K9Jq5kQcelLoPNQcYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB3999.namprd11.prod.outlook.com (2603:10b6:208:154::32)
 by BN6PR1101MB2161.namprd11.prod.outlook.com (2603:10b6:405:52::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.18; Mon, 28 Mar
 2022 19:04:05 +0000
Received: from MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::d898:84ee:d6a:4eb1]) by MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::d898:84ee:d6a:4eb1%6]) with mapi id 15.20.5102.023; Mon, 28 Mar 2022
 19:04:04 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "dave@stgolabs.net" <dave@stgolabs.net>
CC:     "rafael@kernel.org" <rafael@kernel.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "Jonathan.Cameron@Huawei.com" <Jonathan.Cameron@Huawei.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "Moore, Robert" <robert.moore@intel.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>
Subject: Re: [PATCH v2 1/2] PCI/ACPI: Use CXL _OSC instead of PCIe _OSC
Thread-Topic: [PATCH v2 1/2] PCI/ACPI: Use CXL _OSC instead of PCIe _OSC
Thread-Index: AQHYQKfooX2ZsejZek+ypodOOGCm/qzVI9KAgAAIDIA=
Date:   Mon, 28 Mar 2022 19:04:04 +0000
Message-ID: <c25d5f67db41ff10fe1e43ba62837114d388a3c6.camel@intel.com>
References: <20220326002430.797244-1-vishal.l.verma@intel.com>
         <20220326002430.797244-2-vishal.l.verma@intel.com>
         <20220328183515.nk3e3tr5ecn2amzf@offworld>
In-Reply-To: <20220328183515.nk3e3tr5ecn2amzf@offworld>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.4 (3.42.4-1.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b67ed9f7-0612-4f1e-ae2b-08da10edba82
x-ms-traffictypediagnostic: BN6PR1101MB2161:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-microsoft-antispam-prvs: <BN6PR1101MB216164250CA3163F852C8C65C71D9@BN6PR1101MB2161.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E9aEMZl8MXGGUkwj/r6Da6h6G1Ih0BML65GOuvjEJVfQaV8nBLVwwDR4W8GyQi0gCr79vXS0vhoyE1NMvp9ScjLGX+PEhwLVgYZtJnWYTJF6h5Fbq6heR56zlLTU4Vv7Bbjue2NtAyqYxTA9bklyiDb4FSuEze1fehcNIKbZwz2W+XeZ7jf9PjJllctkOtnXhWadNKgHHsAeUJA7ROxjYLWH7ma0qZq+aZErq8AzLnpBKxeXLltIqPmg2PXV6upAerPDWbLh1VOOJRXCSJkCxVdY4olzivOAps/82qTl9cBpv1BKJlTb2OFHuJcdRSjtUh6KguKtBcnyFLdTX2TfnpiMqSrDr+IgSU+J6MTBJExgK1TEl2OsTECc1SQydl4hRytSroV9wIXJi3V1wynnEtoFkJgVqLpxeUVDsgg02KWBSt1epyV3wKlyZRP+LVErGoc7s9PN+qQreWpwCMJt7vGvNephRB1U89I1bOVLa0PWn/X9NiGQt9e8i23O4HWkU12PPvI+MmstgoxnQ1DlmkM0RglhnTA+ixZ5oegYCNtWZVQlBTOSujRjuD1nm7ltfvQi+EMwsqaZUeeNw6DEgafKeWpKUPSlvghTblBzTt8zutR2Ocp+BwYk1FzlmBC5py3OgzHcJJPyEThE4Fu0FuTheiLE3O+DAgga1XPF0NAAB6ZBs4rEFQfbEZ4uvHpWeCPy+RP0jAFmsmXmUsBHew==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3999.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(86362001)(6512007)(6506007)(2616005)(36756003)(38100700002)(8676002)(2906002)(508600001)(186003)(8936002)(91956017)(64756008)(76116006)(66446008)(66476007)(66556008)(38070700005)(316002)(6916009)(66946007)(122000001)(54906003)(82960400001)(26005)(71200400001)(5660300002)(4326008)(4744005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?elpYZjEwbkFTWmN6TUlrZEladklZTkNiZDlGME51NHBmSFVwOVlEak9IVkxa?=
 =?utf-8?B?TDRXeWpicS9USUE1UEFoZFZqZ0dqNU93WmFnWmFnTERJMUtYOXlTOG9zRWF5?=
 =?utf-8?B?NTIwME1Xclc1aDFaMEdpUzRMZEtkaDFVdFdRS3NvYW54ekUweUNLMjNLY24w?=
 =?utf-8?B?NWRkckdtZDVOa3A3U0liREhsL3FYMElOTmFZdkI4WXhMM2dqSjVKcUJSeFFx?=
 =?utf-8?B?Nzh0WlBacU1KNGZSZndmN3hORllwY21FbENZV3VPaS9sS01UWVVCZGJuVWUw?=
 =?utf-8?B?YVFacVo1a2J1TDRLWTBvT3ZjZkVJQ1VMc3BRdXlkQU9NYWozWDZSTXhvbWIv?=
 =?utf-8?B?QVY3ZmtxR090eENvejlOYlNkSlNpdVhFTjNzQ3h1YU9VVG5JT2w4aVZtZEk4?=
 =?utf-8?B?d0w2N2dNWXhrNE54YTJONm9YVlR3ZFN5WUsrblY1TDdtRHBxczVnWkN6T0Fi?=
 =?utf-8?B?dS9yaExYMDhHYWp6UzJmYmpVNnhiZ25uYlpYVEwrcDBUdXloZDZkSTQ1ZjFN?=
 =?utf-8?B?cUhwcmRENlZLd01xRlExK0FHK3JoSmErbFd4L2xOeGFPZ21CWlJkS1FWV1Jp?=
 =?utf-8?B?emhEbGhZM3hQY2J4R1Z6ZTNseVMxMDdWQzN6ZC8zK0NaaHV1ZGVLcW1LUWpR?=
 =?utf-8?B?azJLMlVBeCtGTUZHdWd1WXkyeDVzU202SFYrL0VZNE9QRHVxZVVMS1Fqd2xS?=
 =?utf-8?B?WkRxOGdSemp2elZsdlkwbmYxb2FCWlB0aVh3UEw3Ump6MzJ5MzNFYWpNR0pK?=
 =?utf-8?B?QXZ1dXcvRkVkQmI5T3JQc2lONWpudXhWNmhRVElLSWhSNkE1M3h0US9EckNw?=
 =?utf-8?B?bEZtZ2VxTGlXQ2hDMFk1VkcxZ2tmWEplMXZyZ0VvK0dCalpWZTA4NmM3R1h2?=
 =?utf-8?B?ZGg0S0EvNStCNmh1K0ZDR1lmNHVSNlhmaHJSeldEVjVtVklzcFVUdTR5S3BR?=
 =?utf-8?B?ZG9WOXMrTnJyR08wZUtuc0RVMnVMZnlwVnFmd1hjSmUrNmM3UmlHZThLTGow?=
 =?utf-8?B?VVRrWDBRTUN1WVNxbTZFWkh2aG1lMnpOYUdrVHFoWEtXY0ovdkU0a0xoenQx?=
 =?utf-8?B?TlpTWHIxQVJQZjN0QXlpd0QreTNFRFJjUjIvMnF0NlZlTmIxRkptY1NpOHhK?=
 =?utf-8?B?eGFkekcyMElJa0dUbDMrMXk3UTAvQWQ2aHFVTmE1T1EvOVVSOUd1cFMwTFRK?=
 =?utf-8?B?UElPblZuSHZhZDNSelRsUjhhSFNQZXJxbFpkMFhnZVk4ZFFoSklOWWtoeWR5?=
 =?utf-8?B?WFMxcmV3eTRLZ0ROWlVYRlprR1U5WGxuamF6UTdnOXNXV3JqTlducFc5ZmZG?=
 =?utf-8?B?TVBER2hnZm40cEhHU2haN1hYMnJxdjRBRlpRcUhsZ05XbktsTnFUbDl1NCs0?=
 =?utf-8?B?SDRaWXh2N0YwODg0RVZvNXYrd3lLY2M4bXZwbW4vMTQ5UHMzd2JFWXlybFA3?=
 =?utf-8?B?R0dDMDczaDVSMEJVQjNXd3R4L1pRTm96U0taM2JCV0Jxa3IrUkQxWng0SzUv?=
 =?utf-8?B?M2VFRTZjK3ptRk9Kd3dqSUxtdWJ4RnNwNUgwbXZhTHA5czFZUWcyNEk2d0pw?=
 =?utf-8?B?YmRQZHBIUWVqNnpjemxQYTNwdEFBVHRtei9td21MWVdZQkM4clU1bVBUaGFG?=
 =?utf-8?B?SURSMTU5ZFFXby9HUTRlTk5CbFdFa2Vhc2UycEk2akprVTJ4WDRKRXh2YlB0?=
 =?utf-8?B?RG5TK1NXbGFDL2lQSGJCcmJRYjV5TVhPM0t0aFQrRkxDMFdqR2MrOHZaNEpr?=
 =?utf-8?B?U241Sk02dm9ReW5seDJ4cXdQWDgvcE0zU0hCSVBBOXh2UmxFT2dRNFpuSmV4?=
 =?utf-8?B?OGhQOHpRUzQwc0dNVkhreWZOTE55cUpmVVVHNXJuL1NUbEltWURTM1YwcHdV?=
 =?utf-8?B?c2M5QWs4aU1Ra25OSHlBbXV6bmMvUFlBQXZ6OEpOUGl0RElDejRPenlSdlJY?=
 =?utf-8?B?K0hwUFp0akdXZTNVbHg1d2xmNzlaUnNDTnE3N3p1RXpPL1NrV2daQ3h2MTJl?=
 =?utf-8?B?cU90TlJBdTNIVFl4aTRvSXdTK0Q5a2ZaTFdzcmF3L3NyY0JoRHBhSU0yejNX?=
 =?utf-8?B?ZnBJR1ZYNWM2UjUrUy84TCtQRWRoRk9lSG9tQk9TMzU5cENLK0xaZmkyaU50?=
 =?utf-8?B?bCttbFQ5VzIzeHhpMnJETm9DTm9ZdWlLRitweHFTNEpvTjFWVXVzTTlkNlRZ?=
 =?utf-8?B?Z0lHeU80TFFwWlhjaDE0OFJmdUk4SHg4WGYvQWNPd05Wa1dRUkZIVGhZSGM0?=
 =?utf-8?B?RmVBZnBQeDhmSkpjSEE3N0VGVGxSaE5xdzQyQk5PMzkzcWd6aDJadWdLakdu?=
 =?utf-8?B?MzBIYjR3MGExOUpnaGJ6YmtMSkUvU0hJTlV2b0RCQlhTZm1NajNISkFSQk9J?=
 =?utf-8?Q?R0m9rT7AijngIfy4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AA61BDADAE383A4E9C98E05D1F34EDF1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3999.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b67ed9f7-0612-4f1e-ae2b-08da10edba82
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2022 19:04:04.7360
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7QdWwEV1s1f6OR714S8I1CLpO4fKhAXystPTrQseiuORSY+l5vJWgJWysBC40z+0KqpeS++2HxP2UdJXDoG2h3Do3UJQq7KOmII43BrOwA0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2161
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

T24gTW9uLCAyMDIyLTAzLTI4IGF0IDExOjM1IC0wNzAwLCBEYXZpZGxvaHIgQnVlc28gd3JvdGU6
Cj4gT24gRnJpLCAyNSBNYXIgMjAyMiwgVmlzaGFsIFZlcm1hIHdyb3RlOgo+IAo+ID4gK3N0YXRp
YyBib29sIGlzX3BjaWUoc3RydWN0IGFjcGlfcGNpX3Jvb3QgKnJvb3QpCj4gPiArewo+ID4gK8Kg
wqDCoMKgwqDCoMKgaWYgKHJvb3QtPmJyaWRnZV90eXBlID09IEFDUElfQlJJREdFX1RZUEVfUENJ
RSkKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gdHJ1ZTsKPiA+ICvC
oMKgwqDCoMKgwqDCoHJldHVybiBmYWxzZTsKPiA+ICt9Cj4gPiAKPiA+IC1zdGF0aWMgYWNwaV9z
dGF0dXMgYWNwaV9wY2lfcnVuX29zYyhhY3BpX2hhbmRsZSBoYW5kbGUsCj4gPiArc3RhdGljIGJv
b2wgaXNfY3hsKHN0cnVjdCBhY3BpX3BjaV9yb290ICpyb290KQo+ID4gK3sKPiA+ICvCoMKgwqDC
oMKgwqDCoGlmIChyb290LT5icmlkZ2VfdHlwZSA9PSBBQ1BJX0JSSURHRV9UWVBFX0NYTCkKPiA+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gdHJ1ZTsKPiA+ICvCoMKgwqDC
oMKgwqDCoHJldHVybiBmYWxzZTsKPiA+ICt9Cj4gCj4gcmV0dXJuIHJvb3QtPmJyaWRnZV90eXBl
ID09IFRZUEUKCk9oLCB5ZXMsIG9mIGNvdXJzZSAtIEknbGwgZml4IHVwIQoK
