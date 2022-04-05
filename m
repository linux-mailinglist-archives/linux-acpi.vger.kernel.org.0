Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E01014F46CB
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Apr 2022 01:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239796AbiDEUpF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 5 Apr 2022 16:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457514AbiDEQDT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Apr 2022 12:03:19 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A0FBDB;
        Tue,  5 Apr 2022 08:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649174235; x=1680710235;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Owefvrvwa3o4jn9fcb5kJTn5oV3HfsC7yeuLofbYp/c=;
  b=Y0LTHVVF3UWaVNRcGjiSpuG7RMFaBfWUdQ5o7mkayLiq4GGAVb3CGr9J
   BvYdAZaAqINHgQxIuaBRa93mHI7qErecKn2Rf4X5dL5j9ORgcwSJmmo1K
   JxRXq8PQWPFuGzDWLoAtGH7+l9taE+2uh5xkofW0v+TWQEXpmu13c4v2x
   zOM/OQhcmxqC8Cj2fteDNHUnMaGVNwOn0rX5hzHKHq6NvK0tlS14HCbC3
   r6B2koj1INyumz7L+C4rbOAXRhFYohBtVlEXxDlglb7NtgKhHVEW1aKug
   8/sVLmPA+A4SFOHUiKqD7hdrTNvQ9Kur8/jK0jIMA/2xn9RhYy0F0A53d
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="248302397"
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="248302397"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 08:57:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="651943219"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga002.fm.intel.com with ESMTP; 05 Apr 2022 08:57:14 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 5 Apr 2022 08:57:13 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 5 Apr 2022 08:57:13 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 5 Apr 2022 08:57:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NI9wSbyY1bOIxOcjXsWouVt9kpfmyQWlbiiWzmuJWCNyxecruYmOQeHo91/pW6lLoBStZ2bCxwfbabxvPDkltNOd/kYh6oqINzA3uUb8dGI15VPfj4HEoRObQCl0IlOmCkDdu67IBaDfGfzGMhIwIkm246vglEamssfbnFr+NQ8JFtAdVpq2QkX534Xa7U9vZY1A4mBlaxP4sgfZQWwfx0Fw31pT+fIzDO+l2T6uAKEZmfylLMWK3fFqV+UrwGhJp0ZpntYnEoiiUQg28eWftkihOF9J/Ix2nTb2Wjsv/+DE3AcZkYtjliPAZbWTQijkf9b/zUI5zBNZDocba67fdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Owefvrvwa3o4jn9fcb5kJTn5oV3HfsC7yeuLofbYp/c=;
 b=bbsbBj86aQ0YrResKnaQP5cBTbFtrzBMCR4FSJsE37/J5bJnzSNAkH7Ry3XeLyrlhaNiBlt0vjHX+oNZnSrzd1XwShgckqUNRpgAlmI3ZAHtKNfJaWCukeVakxkn9ikhih4Ve3+5MGkBkNEeieo5HfolGEpwQsL/iY8y2Ui/yoQiiOFfcG9+MtmfQxHc0urEJDy3ZQ4BpCojVabghABILahKN8TMUANn8fRcNUo5X4yy/ZR8VqfHXdzWC3VZCIU+gxyx0QJgMvnQ7sUhG5N/hAIAw0lm/FsXGW+uTijgzJqAz4aosThd02iNGjdX03/vdcLswRD3U2ob9EziPuZHxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB3999.namprd11.prod.outlook.com (2603:10b6:208:154::32)
 by BN6PR11MB1841.namprd11.prod.outlook.com (2603:10b6:404:102::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Tue, 5 Apr
 2022 15:57:12 +0000
Received: from MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::41a:5dd4:f4b3:33cb]) by MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::41a:5dd4:f4b3:33cb%7]) with mapi id 15.20.5123.031; Tue, 5 Apr 2022
 15:57:12 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>
CC:     "rafael@kernel.org" <rafael@kernel.org>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "a.manzanares@samsung.com" <a.manzanares@samsung.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "Moore, Robert" <robert.moore@intel.com>
Subject: Re: [PATCH v4 3/3] PCI/ACPI: negotiate CXL _OSC
Thread-Topic: [PATCH v4 3/3] PCI/ACPI: negotiate CXL _OSC
Thread-Index: AQHYRTzX1ng5YjcXVUWchGA2uAQ65KzbhucAgAAPMYCABKT3gIABRhQA
Date:   Tue, 5 Apr 2022 15:57:11 +0000
Message-ID: <eda143f3eb13a1494cbea93b19fc4c490ce9f66b.camel@intel.com>
References: <20220331202022.1823174-1-vishal.l.verma@intel.com>
         <20220331202022.1823174-4-vishal.l.verma@intel.com>
         <20220401204014.khgozoeu6biirknu@offworld>
         <CAPcyv4iGtgO6tqLV_UjOsORmC0q-Kw0y5yvstXd=OO8vQ=9XoQ@mail.gmail.com>
         <20220404203005.wnee6i3aovvchpcr@offworld>
In-Reply-To: <20220404203005.wnee6i3aovvchpcr@offworld>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.4 (3.42.4-1.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ddbc3d68-d91e-4c61-e012-08da171cf27a
x-ms-traffictypediagnostic: BN6PR11MB1841:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-microsoft-antispam-prvs: <BN6PR11MB18418A2A4FD053B010BFA422C7E49@BN6PR11MB1841.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jGUfYw2Wn3CTRR8ob73V/9nQXkXEHFHGnfRtVXM/OZYNYoeYHDIU62z8cYVU8VHP9IZ/MDHpie+Jbaw4nXiIP4/cKjZIxmGaFFx6ZhC4KGDQQxVCZ+BfJUexzdKZ1Qo4XG4UlOK6++71oy9RscDUoGvd4XNWUJG/pT6vT3ugULo/GCWmtT6LT77SZSuS4rMMTTrug6JFDGkzpyCPlqOC5DtK5j69oVisjsO3ro1sEaE6VkSh1PNMbJFq4F7/vIFT13lfn2+1R4fBgHjW1WHuRWmUNCbMIWHWXaE1iChNhQCsy7GXeTCsoOO5xY3SqeulJqOA6VkyycRJqV1qd3+8ZkcCN5Yfoj610gOcS/ZB0pKlzTO+J/fKmKQq9bcSg5WX1SQ6RrmuJuWvY0mibcsQ087OYI906iqpSJ5H6Rb6E7/Ok4KpuI9yKFhAeNsxdaYXUYPZZ7pKVWkFUrT549+1SCJQYqqdzC7X9OqrDdw/gNeBRjSJSKnNyWxDl1h/xWi3Ln01/sQYNyYqb2CZtNrX3EyQSH1tw6pbVw/l4kgAXQSyDwyQTANFJQGXWyj8HBmza+fvlPkDfNwcaYWNArsH5D/cpZZTF1+/dy0EZIJXIXEk6gs3/rogSK6TVow5mIYNo32w+M1xpiXIvuNN8HQuwavB4K79DY6FNS9c33m2d+8M6Geo2hV+PvBarpzLxW2vqemlhE3jp9Y5uJuY3vWIySVgy6uJwlw2uHIOBqzP1PthmKtuHAo7lNREySccvB15Y6hIt3M33IZeOK3Iqk7uX/Fw/Yh93GUtHcV9MD3L5CQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3999.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(316002)(66946007)(53546011)(91956017)(83380400001)(66556008)(6506007)(508600001)(76116006)(4326008)(8676002)(66476007)(66446008)(64756008)(36756003)(38100700002)(2616005)(966005)(82960400001)(122000001)(2906002)(54906003)(86362001)(6486002)(110136005)(8936002)(26005)(38070700005)(5660300002)(186003)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cWJOenlqWnRkb0JZTEtkVCs5aHJXRjFQbWwzajg4blNTT2JBb1lhUVVNd0J2?=
 =?utf-8?B?L2NoY3loRGVlN3FtNUNWT3F4b21jN3J3dk44ODJXcTRHSDZRTkZGaDJOSjdW?=
 =?utf-8?B?NXVHN0dOOW9RRVV3YXhhVFQvOVFtQ2NOTkNZSFY0NWlENFBzQnNKeEIwTW95?=
 =?utf-8?B?RjFjaVFCR3p6WHpaMlNrWVBkVGRncmx2OG81WndrMVhaNEIxNWEyeVp2L0hz?=
 =?utf-8?B?d0JJWExaN1h6VW5ERDEvOXRYVy91M1doaDdxeWp5YTJtNHFQRjFLSGpFdGRB?=
 =?utf-8?B?cGNKZkhhZWxPam1KQmk3VFFJYXNpaHZsc1Yya3JLNHVOQ09XL0x5V0JvaWRH?=
 =?utf-8?B?TVpESlhlQUJuNy8veHV6TzVpVVJ2Y3JyYU9DajZsaU91OUZTbUFWdVhVdnJW?=
 =?utf-8?B?T0xnQ1lnOTAwcU9lYkdMaHF1OWgvLysxVksrY2JzK0QvRGhUZittRlB6aWxT?=
 =?utf-8?B?d0RMTk04NnVoQThvMklnczN0dDNTZnpwZnlmL1k4MjVmOXljVGVnSnVTb0VH?=
 =?utf-8?B?TlRNbThMYkdqZnl2WTdNQVBUUnIzNFB0V3BiYkl5RnR5OGVrRnl4UXNIN0gr?=
 =?utf-8?B?U1hwaFF1bUtjcE9jSTl0TzlvOVRZc3ZzRWdDbEhaMkZGUU03RXVNSmVDVDhr?=
 =?utf-8?B?RzlCR1c3TUFzakJJZUxlak1jaEI1a0thMUJoRUxwUEpFNTlTK0JyUGVPSHkv?=
 =?utf-8?B?NXo3R0xTMytablJmRnA1ZWl2ZVVBWDIwK0diTlo0MTd0a1Zmb2JlWCtHSTFT?=
 =?utf-8?B?SGtGV2V1YWFOdE1ia0REaytPRWtQVDBDOFRGQ2dYTkJuYzRNbnZIS3p4d0hM?=
 =?utf-8?B?UkhsNm5ObDdSWjFVWFd4YzRQVDRUL096N3MyMTBndHhVd2pXS0EySWoxdEU3?=
 =?utf-8?B?V3VsTEt6bDBMWWJ0LzdQRDRUUUk5SktOZmFTWVJ6dGZIWm5idTNCRHBjOFhZ?=
 =?utf-8?B?OW0vN2E0KzEzZ0cySmpxUWpBSzdFb0lLeTBqRUx5eWthN0Faa2pqSE9wREZ0?=
 =?utf-8?B?ZWdQb2pCWFF6d2NoeU9yVEZPWUh5Tm1HK2VZUmx4RENVOGhEMi96RGxJUlhP?=
 =?utf-8?B?UDJaQmlLa3NnMHlnVzQvanpsNXJ0Uklhc1g0bDVUNThXVUY3bGVJbE40V2gy?=
 =?utf-8?B?NWhPQ0x2dkcwRWk3bHZzWUN2TVR3QnhUbFQ5SHpBN1NUT3pPTUNFSGIweWEz?=
 =?utf-8?B?UFE0SEFOdkpsaHkyY2hRaWw4cFlDWlhzQnFzaFh1bGdLanI0QUg2Q1JBbTJN?=
 =?utf-8?B?T0p3ZVFVSyt0Uzk0K2diaW14MFNka1MvVFQvVTQ4bjAwcnk3Mnk0WXhnYXQ1?=
 =?utf-8?B?bU1JVHdGM3V6eEFtOGJNdzNzL0QvMjlSK2w3cjRvYk9KTTM4Z0lXSmYydjBG?=
 =?utf-8?B?QUVNaDJHYVh5RVE5SHNHTExIcXR2R25lZjhiRjhrS2FkUDRUQ3dyY1RiYnFl?=
 =?utf-8?B?UG1SOEdRRGZIdnMrWUIxK2FXTnA5WkdhVnB2cEl2aFhKWi82Sm0rSm12dlBV?=
 =?utf-8?B?NjRTdFlaUmtzam56a1hhemlXVW1HUzhNQmhoVjJHdXBEQUR2UWNhN1dHcjN5?=
 =?utf-8?B?UUZEY2NKVEVvMGRFTUlWUkNpeTFqMjBrd2F5R3g2TGk1UHk2K3lhMGlzeUl4?=
 =?utf-8?B?ejd0RmRXeGZTWXp5ZTg1NytycXhNYlVPVjlzUGRoOXNrLzlmTEFrMFpSdHI3?=
 =?utf-8?B?U2hUdE5RbUtyLzJBMnMwZ0IvWFQvT0RZcldxR21mMVBmQ3NsN2dTdklXc0Iz?=
 =?utf-8?B?R2w3djZmTmRPbENuTDBrTGQ2RUc5NjYrYVBBV05DdVNlNUtHczVnU2FGZlo0?=
 =?utf-8?B?WDdtQm1ES2xYQ2tlVHdaKzY1YzVNVHRmN3IvZXZEYTZJS1gzc3R5K2xTU0o0?=
 =?utf-8?B?c1VZS04zT2ZWbmlqMTNKTlU4RmpHeTZQbDhsKzZpSnQrTFcxN3NMQW5xWFZh?=
 =?utf-8?B?dTB1bWpWZW5wUXpkWEtPbHpOVmNZaHl4TXRLSUR3TVByWUpRUC9YL085aG85?=
 =?utf-8?B?M0tGM2xDUEcxdTVOSW80cVFOcG5LcWwyR0FkSFdDQkszRC8yYVNUVVdJWUhT?=
 =?utf-8?B?ekhFdG9VNUlyMkY2b0JtcUoyM045aXBRKzJWK2RzMkJ5MWRpc2lTYkUvdGZt?=
 =?utf-8?B?K0p6Mzd6elRycVlMa0RqeFh0Z1Z4anhCNjdiRFlNM1lBQXhIZy9rZlFucVUv?=
 =?utf-8?B?RUJ0VHliTW9iQWRFZXJqWWlnaUFqQU0rTWhBNkRPOGEzRlhLNTZSSkVTOGdP?=
 =?utf-8?B?OCtpVHZLOTVLYnZ5bTk5RnhSbm80VnAzMVpMLy84UTBsQlVxaWRrNnBqT2RR?=
 =?utf-8?B?TVZsaUR6N1JUTzZ6Z0pNTkVSZ2crcFJKMHRuRWdzd2dvNDJYd2tWVDdlNGlK?=
 =?utf-8?Q?vtC0CbwqUpjK87eyJYOjoe7AhR7oWOhNaPFa3?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <563FD57517D88941BFAC0E117BB6B59C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3999.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddbc3d68-d91e-4c61-e012-08da171cf27a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2022 15:57:11.9914
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qv9TvUwHL5e74HaAsNYQc9yQUiwTIzOXC8+Cp5kr3r1nNnVCa4UMzoDPb2rFLwfkQQV7L3+VzR6qVVdIf5xKodeMXQJxB5V/joAW4czv3ts=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1841
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

T24gTW9uLCAyMDIyLTA0LTA0IGF0IDEzOjMwIC0wNzAwLCBEYXZpZGxvaHIgQnVlc28gd3JvdGU6
DQo+IE9uIEZyaSwgMDEgQXByIDIwMjIsIERhbiBXaWxsaWFtcyB3cm90ZToNCj4gDQo+ID4gT24g
RnJpLCBBcHIgMSwgMjAyMiBhdCAxOjQwIFBNIERhdmlkbG9ociBCdWVzbyA8ZGF2ZUBzdGdvbGFi
cy5uZXQ+IHdyb3RlOg0KPiA+ID4gDQo+ID4gPiBPbiBUaHUsIDMxIE1hciAyMDIyLCBWaXNoYWwg
VmVybWEgd3JvdGU6DQo+ID4gPiANCj4gPiA+ID4gVGhlIENYTCBzcGVjaWZpY2F0aW9uIGRvZXMg
bm90IGRlZmluZSBhbnkgYWRkaXRpb25hbCBjb25zdHJhaW50cyBvbg0KPiA+ID4gPiB0aGUgaG90
cGx1ZyBmbG93IGJleW9uZCBQQ0llIG5hdGl2ZSBob3RwbHVnLCBzbyBhIGtlcm5lbCB0aGF0IHN1
cHBvcnRzDQo+ID4gPiA+IG5hdGl2ZSBQQ0llIGhvdHBsdWcsIHN1cHBvcnRzIENYTCBob3RwbHVn
Lg0KPiA+ID4gDQo+ID4gPiBIbW0gYnV0IGZyb20gYSBMaW51eC1wb3YgZG9lcyBpdCBtYWtlIHNl
bnNlIHRvIGFsbG93IGhvdHBsdWcNCj4gPiA+IHN1cHBvcnQgaWYgdGhlIE1NIGNhbm5vdCBoYW5k
bGUgaXQ/DQo+ID4gDQo+ID4gSSB3b3VsZCBzYXkgeWVzLCBpLmUuIGRvIG5vdCBjb25zaWRlciBD
T05GSUdfTUVNT1JZX0hPVFBMVUcgZm9yDQo+ID4gT1NDX0NYTF9OQVRJVkVfSFBfU1VQUE9SVCwg
YnV0IHNlZSBiZWxvdyBhbmQgcG9rZSBob2xlcyBpbiBteQ0KPiA+IGFyZ3VtZW50Li4uDQo+ID4g
DQo+ID4gPiANCj4gPiA+IEBAIC01MzEsNyArNTE4LDggQEAgc3RhdGljIHUzMiBjYWxjdWxhdGVf
Y3hsX3N1cHBvcnQodm9pZCkNCj4gPiA+IMKgwqDCoMKgwqDCoMKgIHN1cHBvcnQgPSBPU0NfQ1hM
XzJfMF9QT1JUX0RFVl9SRUdfQUNDRVNTX1NVUFBPUlQ7DQo+ID4gPiDCoMKgwqDCoMKgwqDCoCBp
ZiAocGNpX2Flcl9hdmFpbGFibGUoKSkNCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBzdXBwb3J0IHw9IE9TQ19DWExfUFJPVE9DT0xfRVJSX1JFUE9SVElOR19TVVBQT1JUOw0K
PiA+ID4gLcKgwqDCoMKgwqDCoCBpZiAoSVNfRU5BQkxFRChDT05GSUdfSE9UUExVR19QQ0lfUENJ
RSkpDQo+ID4gPiArwqDCoMKgwqDCoMKgIGlmIChJU19FTkFCTEVEKENPTkZJR19IT1RQTFVHX1BD
SV9QQ0lFKSAmJg0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgIElTX0VOQUJMRUQoQ09ORklH
X01FTU9SWV9IT1RQTFVHKSkNCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBz
dXBwb3J0IHw9IE9TQ19DWExfTkFUSVZFX0hQX1NVUFBPUlQ7DQo+ID4gPiANCj4gPiA+IMKgwqDC
oMKgwqDCoMKgIHJldHVybiBzdXBwb3J0Ow0KPiA+ID4gDQo+ID4gPiBBZnRlciBhbGwsIHBlciB0
aGUgQ1hMIDIuMCBUeXBlIDMgZGV2aWNlIEhvdC1BZGQgZmxvdzoNCj4gPiA+IA0KPiA+ID4gIiIN
Cj4gPiA+IDcuIENYTCBhd2FyZSBzb2Z0d2FyZSBub3RpZmllcyBPUyBtZW1vcnkgbWFuYWdlciBh
Ym91dCB0aGUgbmV3IG1lbW9yeSBhbmQgaXRzDQo+ID4gPiBhdHRyaWJ1dGVzIHN1Y2ggYXMgbGF0
ZW5jeSBhbmQgYmFuZHdpZHRoLiBNZW1vcnkgbWFuYWdlciBwcm9jZXNzZXMgYSByZXF1ZXN0DQo+
ID4gPiBhbmQgYWRkcyB0aGUgbmV3IG1lbW9yeSB0byBpdHMgYWxsb2NhdGlvbiBwb29sLg0KPiA+
ID4gIiINCj4gPiANCj4gPiBJZiBJIGxvb2sgYXQgQUNQSSBob3RwbHVnIGl0IGlzIHRydWUgdGhh
dCBDT05GSUdfQUNQSV9IT1RQTFVHX01FTU9SWQ0KPiA+IGRlcGVuZHMgb24gQ09ORklHX01FTU9S
WV9IT1RQTFVHLiBIb3dldmVyLCBpdCBpcyBhbHNvIHRydWUgdGhhdCB0aGVyZQ0KPiA+IGlzIG5v
IGV4aXN0aW5nIF9PU0MgZm9yIG1lbW9yeSBob3RwbHVnIHN1cHBvcnQuIFRoZSByZWFzb24gaXMg
dGhhdA0KPiA+IEFDUEkgbWVtb3J5IGhvdHBsdWcgcmVxdWlyZXMgdGhlIE9TIHRvIGFja25vd2xl
ZGdlIC8gY29vcmRpbmF0ZSB3aXRoDQo+ID4gbWVtb3J5IHBsdWcgZXZlbnRzIHZpYSBhIHNjYW4g
aGFuZGxlci4gT24gdGhlIENYTCBzaWRlIHRoZSBlcXVpdmFsZW50DQo+ID4gd291bGQgYmUgaWYg
TGludXggc3VwcG9ydGVkIHRoZSBNZWNoYW5pY2FsIFJldGVudGlvbiBMb2NrIFsxXSwgb3INCj4g
PiBvdGhlcndpc2UgaGFkIHNvbWUgY29vcmRpbmF0aW9uIGZvciB0aGUgZHJpdmVyIG9mIGEgUENJ
IGRldmljZQ0KPiA+IHVuZGVyZ29pbmcgaG90cGx1ZyB0byBiZSBjb25zdWx0ZWQgb24gd2hldGhl
ciB0aGUgaG90cGx1ZyBzaG91bGQNCj4gPiBwcm9jZWVkIG9yIG5vdC4NCj4gPiANCj4gPiBUaGUg
Y29uY2VybiBpcyB0aGF0IGlmIExpbnV4IHNheXMgbm8gdG8gc3VwcG9ydGluZyBDWEwgaG90cGx1
ZyB0aGVuDQo+ID4gdGhlIEJJT1MgbWF5IHNheSBubyB0byBnaXZpbmcgdGhlIE9TIGhvdHBsdWcg
Y29udHJvbCBvZiBhbnkgb3RoZXIgUENJZQ0KPiA+IGRldmljZS4gU28gdGhlIHF1ZXN0aW9uIGhl
cmUgaXMgbm90IHdoZXRoZXIgaG90cGx1ZyBpcyBlbmFibGVkLCBpdCdzDQo+ID4gd2hldGhlciBp
dCBpcyBoYW5kbGVkIG5hdGl2ZWx5IGJ5IHRoZSBhdCBhbGwgT1MsIGFuZCBpZg0KPiA+IENPTkZJ
R19IT1RQTFVHX1BDSV9QQ0lFIGlzIGVuYWJsZWQgdGhlbiB0aGUgYW5zd2VyIGlzICJ5ZXMiLg0K
PiA+IA0KPiA+IE90aGVyd2lzZSwgdGhlIHBsYW4gZm9yIENYTCBjb29yZGluYXRlZCByZW1vdmUs
IHNpbmNlIHRoZSBrZXJuZWwgZG9lcw0KPiA+IG5vdCBzdXBwb3J0IGJsb2NraW5nIGhvdHBsdWcs
IGlzIHRvIHJlcXVpcmUgdGhlIG1lbW9yeSBkZXZpY2UgdG8gYmUNCj4gPiBkaXNhYmxlZCBiZWZv
cmUgaG90cGx1ZyBpcyBhdHRlbXB0ZWQuIFdoZW4gQ09ORklHX01FTU9SWV9IT1RQTFVHIGlzDQo+
ID4gZGlzYWJsZWQgdGhhdCBzdGVwIHdpbGwgZmFpbCBhbmQgdGhlIHJlbW92ZSBhdHRlbXB0IGNh
bmNlbGxlZC4gYnkgdGhlDQo+ID4gdXNlci4gSWYgdGhhdCBpcyBub3QgaG9ub3JlZCBhbmQgdGhl
IGNhcmQgaXMgcmVtb3ZlZCBhbnl3YXkgdGhlbiBpdA0KPiA+IGRvZXMgbm90IG1hdHRlciBpZiBD
T05GSUdfTUVNT1JZX0hPVFBMVUcgaXMgZW5hYmxlZCBvciBub3QsIGl0IHdpbGwNCj4gPiBjYXVz
ZSBhIGNyYXNoIGFuZCBvdGhlciBiYWRuZXNzLg0KPiA+IA0KPiA+IExvbmcgc3Rvcnkgc2hvcnQs
IGp1c3Qgc2F5IHllcywgdG8gQ1hMIGhvdHBsdWcgYW5kIHJlcXVpcmUgcmVtb3ZhbCB0bw0KPiA+
IGJlIGNvb3JkaW5hdGVkIGJ5IHVzZXJzcGFjZSB1bmxlc3MgYW5kIHVudGlsIHRoZSBrZXJuZWwg
Z3Jvd3MgYmV0dGVyDQo+ID4gbWVjaGFuaXNtcyBmb3IgZG9pbmcgIm1hbmFnZWQiIHJlbW92YWwg
b2YgZGV2aWNlcyBpbiBjb25zdWx0YXRpb24gd2l0aA0KPiA+IHRoZSBkcml2ZXIuDQo+IA0KPiAr
Q2MgQWRhbS4NCj4gDQo+IFRoYW5rIHlvdSBmb3IgdGhlIG92ZXJ2aWV3IG9mIHRoZSBsYW5kc2Nh
cGU7IEkgd2FzIGFzc3VtaW5nIHRoaXMgbGFzdA0KPiBwYXJ0IGFscmVhZHkgZXhpc3RlZC4gSSB3
b3VsZCBvbmx5IHN1Z2dlc3QgZG9jdW1lbnRpbmcgdGhlIGFib3ZlIGluDQo+IGNhbGN1bGF0ZV9j
eGxfc3VwcG9ydCgpLCBzdWNoIHRoYXQgZnV0dXJlIHJlYWRlcnMgZG9uJ3QgYWxzbyB3b25kZXIN
Cj4gYWJvdXQgdGhpcyBhbmQgd2h5IENYTCBkb2Vzbid0IGZvbGxvdyB3aGF0IENPTkZJR19BQ1BJ
X0hPVFBMVUdfTUVNT1JZDQo+IGRvZXMuDQoNCkknbGwgZG9jdW1lbnQgY2FsY3VsYXRlX2N4bF9z
dXBwb3J0KCkgd2l0aCB0aGlzLiBUaGFua3MgRGFuIGFuZCBEYXZpZC4NCg0KPiANCj4gVGhhbmtz
LA0KPiBEYXZpZGxvaHINCj4gDQo+ID4gDQo+ID4gWzFdOiBodHRwczovL2xvcmUua2VybmVsLm9y
Zy9hbGwvMjAyMDExMjIwMTQyMDMuNDcwNi0xLWFzaG9rLnJhakBpbnRlbC5jb20vDQoNCg==
