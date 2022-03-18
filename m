Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 625A54DE1FA
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Mar 2022 20:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240430AbiCRTx5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 18 Mar 2022 15:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240431AbiCRTxz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Mar 2022 15:53:55 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB6A72EA0D3;
        Fri, 18 Mar 2022 12:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647633156; x=1679169156;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+SD2cMiuN0SNJ/nJdG+JIiy9ic6R2Wgh/8XJkWDknXk=;
  b=eIlhy8hOSxNmDGRRqXYzPOS92gze55Ott2wpeTLPxiEsrLMRYqN70oX0
   T4FBDbpcKkgRFnWVkjHK/AElEaRVSWczFoSLeGrW5xM6SEOOUQ5ynV+yH
   uSC8YK5x4w25Wyua5kHrswZgkkWjkHOFGTfGOtdZHXoUp1tiboDISbPDf
   WK57EXIATY9jk+ibUymdDlzvVVgF7RjXuazCgOkBHn+fjaqFW96bWj6zJ
   ZNe+cJf+veYTD4PM04BazRKu9DX3W9b3lxIK3+BQzJ5KrDTKv57wJ4QJg
   ZUf54BABStHGi6OwiK0U36Cny9cmTcUZSxCfraJQmpODad0irNPCBJwZN
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10290"; a="244686730"
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="244686730"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 12:52:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="822522313"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga005.fm.intel.com with ESMTP; 18 Mar 2022 12:52:34 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 18 Mar 2022 12:52:34 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 18 Mar 2022 12:52:34 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Fri, 18 Mar 2022 12:52:34 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.175)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Fri, 18 Mar 2022 12:52:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GhLDNv7cAWM7t2D8svy4T+ip/0neBMHCwE8TBpSOhY2NxsWm3Z76TJM0U56yMAgWG17BAyEbM/Eo7A+j3N229ZCrHIMsgPud7uuWFcBxlOGSFusrIsyZ321IM0tKrG/rqjrLasjIBnhLal6zhBH0H3KABzAJ0Lv7DUhSMcPOHZImLq+vjhH4I81biZLRkLm1NXknL0vB8zka0GGkh0LRvGYxn6jAA7hMUWr5Ob04K8DyYXBSjS3i/FMznAsbamuPadzEBYaAemRFaRYNIHVv2/C/dR4M63lcaEZ52Vs6qG8r7z9nuZ8ssEVjKddP8AgmMk6WbUDW7Z3NkwVj0LIx+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+SD2cMiuN0SNJ/nJdG+JIiy9ic6R2Wgh/8XJkWDknXk=;
 b=NTZo693q+b/ZbVQ66q/VzPS8vvwEvlw1y+dq7k3MPn0cj0zePVViLeSSmkr7jSJ5dP0sWfp32pC4yK/Jkx8b4j27DQRVTDvMUv8ylCp1TZSvXPHBjmZrjG+I/Wtw1NZlky+C4DnnCnVH7K4XzBXH6cPhlDw+P7bRkDMMR33Hy+VUS4fbutwWAejvTAdh9TrY7pNcX9CEyUD5b89l7kK57CrzvkxwAIKi8PC0ndqN5uICN98ym4+ALBXtkOVcYOD2o6k5ASoZU0z8NqrYsqbq1Migd4PaLtXAUlfRIu01Jf/Jy57uD96XCt3kjEXhs2KUS9+geqIkkaEcfu8rF0KMKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB3999.namprd11.prod.outlook.com (2603:10b6:208:154::32)
 by BYAPR11MB2581.namprd11.prod.outlook.com (2603:10b6:a02:cc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.18; Fri, 18 Mar
 2022 19:52:07 +0000
Received: from MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::d898:84ee:d6a:4eb1]) by MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::d898:84ee:d6a:4eb1%6]) with mapi id 15.20.5081.018; Fri, 18 Mar 2022
 19:52:07 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Jonathan.Cameron@Huawei.com" <Jonathan.Cameron@Huawei.com>
CC:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "Moore, Robert" <robert.moore@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [RFC PATCH 0/2] acpi: add support for CXL _OSC
Thread-Topic: [RFC PATCH 0/2] acpi: add support for CXL _OSC
Thread-Index: AQHYOZXBMPdu05Smy0ueLZZjaP7fUKzDsakAgAHedIA=
Date:   Fri, 18 Mar 2022 19:52:07 +0000
Message-ID: <146514b2e5237a3c027239a75ace69e72671d4c8.camel@intel.com>
References: <20220317002704.1835870-1-vishal.l.verma@intel.com>
         <20220317151938.000042e9@Huawei.com>
In-Reply-To: <20220317151938.000042e9@Huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.4 (3.42.4-1.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 16777497-b0a9-4303-b7eb-08da0918c874
x-ms-traffictypediagnostic: BYAPR11MB2581:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-microsoft-antispam-prvs: <BYAPR11MB2581C3E1038B786651A257DDC7139@BYAPR11MB2581.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bq3KjOGFhP1pVfpkWb5J4j0gpVg5FBlIK3n6+2lqGFLbzOW4q8lZ5zH26cvdiH65uQGif7Ng9vy9ayCCWKVO0uLLmCxRxVq2hcPVmShF442l4Ax/qaOIhO/1QqEUrPaEletXBX0vopTYj+bzDEKutfW9ov1g3dyW5v+0sgH6c0e0Fb5NE0VnCmtIlQy/gQLWYflZe5cqtazpkmFbv9WEFcMHsPYezuchE2k/psECjFp55gChFoCe5gj++lObgRmsviiP//5Do2fBupO9vNY5aB0PRj4y87lwVJvMJnBOZ6M3KyY/wftRfxTckd6TJF3qjeQ80GOeGhUYhx2UsFGRiAuK1ldEB5AzjONdJIC3ftK6PxuxOTOdKL0nT7t3GGAxtEQDo93ClT44uQhBbIM7TO1QOURuoERfnJzL3h2FALtdfE1WPadm8yMxJ2M1LVYGVHnIyz1jEXHjH8euT8XzgflyoH6WAkW40EZVN8h7U1ph06dZ2reLhWumiUdLs66QUhSklSlYrRXSE4vop7tf27DEw79RWHDZ7YrdigmW6XoWPoEmlGjeGdI3wWzE1KMcthgw58mBFk+ly8LPgig6USd4Cb6aFtjpBMOlJ5Au82QLeYjDb+TWtGckAsuvwFqCnjZ1EEotzRcGLcHStciyGm9AmuUZm+Iiah1/rpiSv1AZnvJOWlnCX52yqRxU9024lWWNILtKVfYzSQAbBBAoZcWlfLy0jEV8WjxeNqM4SpCocUSAQqumMbmAANX+FuWgW6YifHT+uGVJWysQKXiv6Vr+HR+t2p2p5/Tz49SIFaUROuNQ22oNp0RZJSfvnR6eKBIvEywE73JEUOzSrHrVkA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3999.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(66476007)(66556008)(66446008)(4326008)(36756003)(91956017)(316002)(66946007)(76116006)(71200400001)(54906003)(64756008)(6916009)(966005)(6486002)(6512007)(508600001)(8676002)(122000001)(86362001)(83380400001)(26005)(186003)(38070700005)(2616005)(82960400001)(6506007)(5660300002)(8936002)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VW5OVTY3SkR6K3ExR21NTHpSMzlJclVHRlNhTXlKTkIzQlRONEdWMFlXN1ls?=
 =?utf-8?B?RTlxOXFwdzZ6SUcwUHFWTlQvK09Yc0pKOG9OZGZaMUdacUx0RFc3c2NUZlR6?=
 =?utf-8?B?TzJKcmxQb0lHdXVMYllCVXVUSW9obUovZVdjL2RpTFliaURRTDhMUXVkQVRs?=
 =?utf-8?B?NXM1bWlVcCtCcUN6WkVyQVZ0NGYxbk5CS213OERtOEpaNkI2UTE5cmdzeEhG?=
 =?utf-8?B?Z1RtOWJueTFpaFkxNjFVWEFHV29LdWdHYk9rWUR6OG92KzBwYjlRdXI5bm5z?=
 =?utf-8?B?UEdheDZTS0E4Mm8rajhBSGxwMHliQ1hxdjF1OFBaM25obXJFQlJRMml5UFls?=
 =?utf-8?B?NjB0dHltSkJENWNhczVTRG9JOUdmOFpyeUY3Skh2d2lKOUVFZlBvRUc5Z1M2?=
 =?utf-8?B?VlQzbTRPRURwZHJMblN1QjJNVTM4Q05hOWJzdTZvZjA3YTdIbmlobnpIWjZq?=
 =?utf-8?B?SmRvNkdvbHVmTTlZUTNvaUxVeUxTdUN1RVBoWDA4VmZkcEtzTjBZYUVrUjBC?=
 =?utf-8?B?aXQzNUNjdU8xZjNXRTltcURXdWh6eEJVOTZuMnN4UkY4ZG5Oc25ORy9TV3hR?=
 =?utf-8?B?V0Ntbk95UzRzYkNnckJYdjk2SlRjV1NlNFYvNk00NUZqb3JCazhpamYzZ05s?=
 =?utf-8?B?L21VelVHOHlRd3crRGdGMHhxdWhPbS9oLytnTXg5Ui9sOXVsZ3o1SzdVYUZD?=
 =?utf-8?B?NmRpeTMzVGgwek9LVFZpendQTWhaK0xJekpsaXU0TG9DdlhqYmVVZnZlbDQv?=
 =?utf-8?B?ZzNpTnVxVGFUbVBhUUtSUW5GNnhMNUlwbjU2R3R3T0xUVSs5OVVBUUhFSlk3?=
 =?utf-8?B?c2RlOVpPZjRYa0l6Y0Q3S2pNeCtrakQ5TzY0L2JGR2dSYnJvOCtFaVNsV2RC?=
 =?utf-8?B?S2kwTktpeGRpaUo3TUw0MDd2RHhEckpmeis5VDhrNHRBOVNFazgwN2ZwNzlL?=
 =?utf-8?B?QnhWbER5ZjZPWE80QTNld0Z3ejBpU0FoeCtEMlF4TVVJRG5pQVNXUC9hSGw1?=
 =?utf-8?B?YzRXSWVIUmkyU0RJdk1qQkQ3bVg4VFU2c2xZWjB0cTZYdDhqYTcrbVlnOUNJ?=
 =?utf-8?B?QmxrWks4cjFJN0FIRXBrWXFFZlRWb1hIUnZvc3NaNGx3eHFNWi9UUVZGV01Y?=
 =?utf-8?B?MjJaZ1ZWNjh4UFBuZktRcStIZlc1ckZWRHdhV2pNaTZBM1RRTGJxNUtMQ2dF?=
 =?utf-8?B?ZVJTOTFXczlrVFIxTzBlN2p6cFA1NUFsWU9lSXJVdTRiMVBEdmplMElOMG1q?=
 =?utf-8?B?UXhOU1NNVVRnSTl1WUMwaXcxSnVabjdYMVF6UUEvSTVXYmJNdDhFdHgreUF6?=
 =?utf-8?B?emJpWmxGQm43NlUzcHg1SXUxMmVUbmdlN0w3NXpWTFJraGNjcU9YL0IrNk9L?=
 =?utf-8?B?K2IwcndSM20ycFlwcEpnZVRhRUFLSWJ6RHlXV3Z0RVFqdVh5eTg2YjcySVpm?=
 =?utf-8?B?dmo0VDRiUmFaTTdVQ1BpWGtJWFdCMjRlYmZ3QkVCY1Y5ZHZLLzF1T2ZKV21N?=
 =?utf-8?B?ZnE5eGRjRDVGcFhTUDVzWUVBS0pwVEY4S1c4WnNFMWZhTU80Wng2TUtLOEFm?=
 =?utf-8?B?Z2MvaWtieDVHc1NTM0EvaWZFZDcybCtZQUU3WVE0c0U3T1JKaEFaZU9ieXBP?=
 =?utf-8?B?eFZNZG5Cb2xIbTRST0ZvZVdENzZCSFJDUk5LRjJ4NWFXMzlVNTVobm5sUDAr?=
 =?utf-8?B?eTNWcjJUMHZMRFhyT3F4RUVVY1ZBamFsakV2SGJTQjNZTC9QVlF3cnBmL3dF?=
 =?utf-8?B?aU1qQjNHUmdDNDY5MVNsRVNxajdGY3pRQ0RyT3d5czVaVDdhdXpIZ2VWK2V0?=
 =?utf-8?B?bW9kNlNlZ1prVjNIQjN0S2lTdzh2WlJmaWlkNk55VEJHdE5QQzh2QXgyMGxx?=
 =?utf-8?B?QWltNGdkSThyMTVGTUc2Y0dMVjVSWUh6NUdMckRnMzRLckJjd3VVSjVUeFdw?=
 =?utf-8?B?c0NpYmFYZ2N3T05KajdWK1RGZmxCU0RuNGVUTnl4R2NZYndKQWNQeWRTREVS?=
 =?utf-8?B?dDhrc29PYytRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1527B5AF2F574143BFADE0C97CB5CE2E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3999.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16777497-b0a9-4303-b7eb-08da0918c874
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2022 19:52:07.2054
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HqxnvZA3KX0PAXtJGN2MaJ7mKf5KWwq8LhTwRXaSU5wQU/FpqpVFlf8ZveGrOvsS6nDqgXBIlQGfpRyagZSFup6Uci1vJHlrGtP1ZpNqvRk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2581
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

T24gVGh1LCAyMDIyLTAzLTE3IGF0IDE1OjE5ICswMDAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBPbiBXZWQsIDE2IE1hciAyMDIyIDE4OjI3OjAyIC0wNjAwDQo+IFZpc2hhbCBWZXJtYSA8
dmlzaGFsLmwudmVybWFAaW50ZWwuY29tPiB3cm90ZToNCj4gDQo+ID4gQWRkIHN1cHBvcnQgZm9y
IHVzaW5nIHRoZSBDWEwgZGVmaW5pdGlvbiBvZiBfT1NDIHdoZXJlIGFwcGxpY2FibGUsIGFuZA0K
PiA+IG5lZ290aWF0aW5nIENYTCBzcGVjaWZpYyBzdXBwb3J0IGFuZCBjb250cm9sIGJpdHMuDQo+
ID4gDQo+ID4gUGF0Y2ggMSBhZGRzIHRoZSBuZXcgQ1hMIF9PU0MgVVVJRCwgYW5kIHVzZXMgaXQg
aW5zdGVhZCBvZiB0aGUgUENJIFVVSUQNCj4gPiB3aGVuIGEgcm9vdCBwb3J0IGlzIENYTCBlbmFi
bGVkLiBJdCBwcm92aWRlcyBhIGZhbGxiYWNrIG1ldGhvZCBmb3INCj4gPiBDWEwtMS4xIGRldmlj
ZXMgdGhhdCBtYXkgbm90IGltcGxlbWVudCB0aGUgQ1hMLTIuMCBfT1NDLg0KPiANCj4gX09TQyBp
cyBpbXBsZW1lbnRlZCBieSB0aGUgZmlybXdhcmUgb2YgYSBob3N0IG5vdCB0aGUgZGV2aWNlIHNv
IHBlcmhhcHMNCj4gcmVwaHJhc2UgdGhpcy4NCg0KWWVzIGdvb2QgcG9pbnQgLSBJJ2xsIHJld29y
ZCB0byBzYXkgIkNYTC0xLjEgcGxhdGZvcm1zIg0KDQo+IA0KPiA+IA0KPiA+IFBhdGNoIDIgcGVy
Zm9ybXMgbmVnb3RpYXRpb24gZm9yIHRoZSBDWEwgc3BlY2lmaWMgX09TQyBzdXBwb3J0IGFuZA0K
PiA+IGNvbnRyb2wgYml0cy4NCj4gPiANCj4gPiBJJ3ZlIHRlc3RlZCB0aGVzZSBhZ2FpbnN0IGEg
Y3VzdG9tIHFlbXVbMV0sIHdoaWNoIGFkZHMgdGhlIENYTCBfT1NDIChpbg0KPiA+IGFkZGl0aW9u
IHRvIG90aGVyIENYTCBzdXBwb3J0KS4gU3BlY2lmaWNhbGx5LCBfT1NDIHN1cHBvcnQgaXMgYWRk
ZWQNCj4gPiBoZXJlWzJdLg0KPiA+IA0KPiA+IFsxXTogaHR0cHM6Ly9naXRsYWIuY29tL2ppYzIz
L3FlbXUvLS90cmVlL2N4bC12Ny1kcmFmdC0yLWZvci10ZXN0DQo+ID4gWzJdOiBodHRwczovL2dp
dGxhYi5jb20vamljMjMvcWVtdS8tL2NvbW1pdC8zMWM4NTA1NGI4NDY0NWRmYmQ5ZTliYjE0YWEz
NTI4NjE0MWMxNGNmDQo+IA0KPiBHbGFkIHRoYXQgd29ya2VkIDopIEkgd2FzIHdvbmRlcmluZyBp
ZiBpdCB3YXMgY29ycmVjdC4NCj4gVGhlcmUgYXJlIHNvbWUgaXNzdWVzIHdpdGggdGhhdCBjb2Rl
IHJhaXNlZCBpbiBhIHJlY2VudCByZXZpZXcsIHNvIGdvb2QNCj4gdG8gaGF2ZSB0aGlzIHRvIHRl
c3QgYWdhaW5zdCBpdCBnb2luZyBmb3J3YXJkcy4NCg0KVGhhbmtzIGZvciB0YWtpbmcgYSBsb29r
IGFuZCBtb3ZpbmcgdGhlIHFlbXUgc2VyaWVzIGZvcndhcmQhDQoNCj4gDQo+IFRoYW5rcywNCj4g
DQo+IEpvbmF0aGFuDQo+IA0KPiA+IA0KPiA+IERhbiBXaWxsaWFtcyAoMSk6DQo+ID4gwqAgUENJ
L0FDUEk6IFVzZSBDWEwgX09TQyBpbnN0ZWFkIG9mIFBDSWUgX09TQw0KPiA+IA0KPiA+IFZpc2hh
bCBWZXJtYSAoMSk6DQo+ID4gwqAgYWNwaS9wY2lfcm9vdDogbmVnb3RpYXRlIENYTCBfT1NDDQo+
ID4gDQo+ID4gwqBpbmNsdWRlL2xpbnV4L2FjcGkuaMKgwqDCoCB8wqAgMTEgKysrDQo+ID4gwqBp
bmNsdWRlL2FjcGkvYWNwaV9idXMuaCB8wqDCoCA3ICstDQo+ID4gwqBkcml2ZXJzL2FjcGkvcGNp
X3Jvb3QuYyB8IDIwMSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tDQo+
ID4gwqAzIGZpbGVzIGNoYW5nZWQsIDE4NyBpbnNlcnRpb25zKCspLCAzMiBkZWxldGlvbnMoLSkN
Cj4gPiANCj4gPiANCj4gPiBiYXNlLWNvbW1pdDogNzRiZTk4Nzc0ZGZiYzViOGI3OTVkYjcyNmJk
NzcyZTczNWQyZWRkNA0KPiANCg0K
