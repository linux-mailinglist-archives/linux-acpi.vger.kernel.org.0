Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE8A644DCA
	for <lists+linux-acpi@lfdr.de>; Tue,  6 Dec 2022 22:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbiLFVLN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 6 Dec 2022 16:11:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiLFVLM (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 6 Dec 2022 16:11:12 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A5245EE8
        for <linux-acpi@vger.kernel.org>; Tue,  6 Dec 2022 13:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670361071; x=1701897071;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iCghek7McJTlgFWx5VwzCBR0HgOvbXdH8H/6azvMvFY=;
  b=c1hDDFMbANuyZOVedjRx2+ifbJ3iJ+PttK9uIRKFWOD/XpkMs7UlZqjw
   R58AyCzEX0/jJQLjB3bDwNVU2XQ5YaeAuivTvdkPFbPsx00T44QsAbZQb
   idDo9FiZxW93Hvu9/VfAmBf4Rs+9h7WKKZFi4c8/89xG6+r+9Ob2WFA1t
   dByZJd6aaWAMmp+YCMOBA1QK7oPhmm+XAp1j5f0apeJ1FUgwOQjM3D4rC
   vKqWAM1ylQDDGd6xbT203E1R4y/qd5RLUcwNijHtqWmYQkcXHxuoxOFbu
   9BTrjZHaYCnNBliVRgYrnu3rXytnHd987wh7NkXW7eFyNv3cghtbaqwsk
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="381024857"
X-IronPort-AV: E=Sophos;i="5.96,223,1665471600"; 
   d="scan'208";a="381024857"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2022 13:11:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="891532641"
X-IronPort-AV: E=Sophos;i="5.96,223,1665471600"; 
   d="scan'208";a="891532641"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP; 06 Dec 2022 13:11:09 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 6 Dec 2022 13:11:09 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 6 Dec 2022 13:11:09 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 6 Dec 2022 13:11:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tr/F8UWsKGnWscgRDVLieNRtuTIK3PPW8dEF5OsBqbQNF+2CID1e8hassgw72rc+QRwr9/FcY32jMXubTnWc0uaYjsYEga2qKtFydr2lo7BVp1qgUECrRS5lL0IwA6mRq39qj7zvIXbnd6tL7rnxUXQKMfLuJmb3vxUJx7y1vqeLtsW1zleam06AVG15teiIqCzR8r6vDY2n546/+A4C2DvrSgWzdXiYX9knCS4ioLk4lV2z8Xma1QwB6G1dYwp3wbBGr4+5l67Rp01hxhQexvnmCnlhfOKoMbWOgS+oWpCwQKC8wWo6AXBpNQTUC9nC/ZQp6W3vnE6g42gSOQfotw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xbYjIjBRsalO47y7WveyXp5GCs3rAvpavtroqEK/jfQ=;
 b=gQw5vHWquXNkJFG4KFcwFIpWVk5w0+tzXVM7mJRp2z64bxgPpWMmPySKg/S7R52begSW4Orzr+ebQzDLenUpZ3uPuuyNbqnxYXU6MHGFcFnuaDbJt+kpD6mtYz0J9dkrNHefVlpDqUrkJ03/mZzc/soL8yt6121O3eYroKVvltZfgAtmSX1ieluviF6DFsLYOS3lVkdxk2g74OuC1psm3fI29U8DVGZoFn8Z8C4756naGQJRxlCLUsoB96wfAxi0y/+4tUBLr3vAuKyeQnGQVG++dBVsfvRcgepwfIYq8t5OaHyncZIflW/PvENC7oYFAP0KgVqYg8yDHRXaMVso6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by CY8PR11MB7339.namprd11.prod.outlook.com (2603:10b6:930:9f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Tue, 6 Dec
 2022 21:11:07 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::4eea:7bf0:e6b0:5014]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::4eea:7bf0:e6b0:5014%5]) with mapi id 15.20.5880.014; Tue, 6 Dec 2022
 21:11:07 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Ben Cheatham <Benjamin.Cheatham@amd.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "bp@alien8.de" <bp@alien8.de>
CC:     "yazen.ghannam@amd.com" <yazen.ghannam@amd.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: RE: [PATCH v2 0/3] ACPI, APEI, EINJ: Add new CXL Error Types
Thread-Topic: [PATCH v2 0/3] ACPI, APEI, EINJ: Add new CXL Error Types
Thread-Index: AQHZCbS4rpo55m8RgEeWbbRb1EJBv65hWXPA
Date:   Tue, 6 Dec 2022 21:11:07 +0000
Message-ID: <SJ1PR11MB608313CBF490328F8C431796FC1B9@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20221206205234.606073-1-Benjamin.Cheatham@amd.com>
In-Reply-To: <20221206205234.606073-1-Benjamin.Cheatham@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|CY8PR11MB7339:EE_
x-ms-office365-filtering-correlation-id: 6124cbaa-9909-48ad-6fc1-08dad7ce644a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Vv5C9RO0FOF3PXBu5KNjZ3DAZ1wiS/ZvmOJpbsy3l9/IQjZ+UbhNyBOzErRz4oJKJAF7/daX6kmrzphYyVOWWUHLEdKjBHdqcdgYWIhiyAgPd4OEi/avZIqd6HZj/252/4RpM99HiLMKUW1wnvM03/ZwtWBVZg438qPWpcrQizmW2hyBKeJshUeVDvwd/c/B6l0zbXjwc1U74oX/QXC9VYAAGEFgdkxbHWmrZYZljfmsKpIygmNphVp6oY19b6cPg4fhQdzbXD++6ybI9qUhJnIyAGQLydCmQt3ZsI7fI60MqhHjNWnpDzPvO3QiEbOUJNjQt0XcRRLQ1NyUgJyzeFiCbz0pVN9hsIz8vUtzQF4WsyIzSWyOkXQdzuOHTj53ctX8wotmaQS/XoyjrhQ+tw9+7qLLeVFSbKsSHO5Zp8+ij4YjphIhNGR0TIMV8r0JjTS5Uj8FSj9VETqqzR+yiSKr7c1Vml/wSL/3mUUn2f56HdHDufXGABgN+/gw3WLI8Zuj7OWttOTs8Pmi1GfK6pP/1tGNy6YMCYq2/+2GeCmkFf4Ke+dw+QRS11sN4CfDHBQC4PJXKDMVXyuXvPlb9LIFCCkJx3CSw29jotHJOdEOfVHETYqHNPiP1vrn7H2uKhXmU6oUg+1UFR+Dp1u/Fac2NpGTvXwN7sI5je+KOH8VdEECU3u0GRF7Cf+1bKqX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(136003)(346002)(366004)(376002)(451199015)(86362001)(4326008)(64756008)(66556008)(2906002)(4744005)(8676002)(8936002)(66946007)(66476007)(66446008)(76116006)(41300700001)(38070700005)(38100700002)(122000001)(33656002)(5660300002)(478600001)(54906003)(316002)(82960400001)(55016003)(52536014)(110136005)(186003)(71200400001)(7696005)(9686003)(6506007)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?njBtdjg2TxgH6pAxK1sTNtsdI6diDB12GVZFWC6GTP3bG+tcDUUJvaCnf3dY?=
 =?us-ascii?Q?0whYvpVaYf8/ydozEJUaZacx8ieczE0pYBuq3adVK/e1XQCAWl6U4Y8H6eIV?=
 =?us-ascii?Q?nzVAUPkWW73/8Kn6qDsdIaG6kpY3K+nQ7K+gFHl0fnUNKdjXTOOrcPPiy95d?=
 =?us-ascii?Q?HWCHBAfO6SL+tXnn7HiQQ2Ov/4ps66X/xN6Nf/vmSMzigWo5R8GRo16SgY0I?=
 =?us-ascii?Q?ZcxVrydhBHIvxpglxfzk7EyxznPhBLrQZRe2V3TsYK0MZw3pO6bmoMdi1jCE?=
 =?us-ascii?Q?Bg8v+ofLbX7wFh30eBV93ZM7KrS+fub5La8E8l9pu+d2ablDep8lvIvjDl45?=
 =?us-ascii?Q?qhXz9G3cFSVzpo3J1ilcZrtGbl6m0ab/maKF/IsaBnX+qX6bRwogewg6kPFE?=
 =?us-ascii?Q?63dS6FEHGCZ4a6fjYHVCA8mqkbcS5dQ/8djW8CHjieAFLTAzDWIZYNcoXs1n?=
 =?us-ascii?Q?XmeA3cjCjIa36LRb612I1DCzzNyDAm197ROsMcsC6s/wS7qQqzWFZfoc3XdN?=
 =?us-ascii?Q?zWbQAgOMi3PT6wqhWkXCHdlGd0lMZrVmUNVgiHmyxi3J0j9oZbzXhbqPQCF9?=
 =?us-ascii?Q?1Hm/RogXyXepeCZC1EX83ulocB0h8Qn49nPKAg1P1trduI5F1lJP6XkMY9/X?=
 =?us-ascii?Q?09BZBlW5+1/bpghCCoaeYz5Difw/KSHkbcOz6qaaJRzM4HAxNXurIl2oDtUx?=
 =?us-ascii?Q?//J9vs6sxTcfRfxWd5Vi83jAD2Eg7M/RuyIip0vz+LPXD2OOYfWKpw4XPYeb?=
 =?us-ascii?Q?vF6jAyXkypNSkPoRYmkbzUhBuU00wYOoXnPW5TFECfSIQFlWGPU0VGCOu/Yp?=
 =?us-ascii?Q?aOXMk5hGYi/+8+ZZBra9A1B9ArVKmH8jabSqyrAS1h1+a5ACK3Jket+7ykeZ?=
 =?us-ascii?Q?eWeTjLBFl3NQiMAnVg83l4M4GOhUhF8iV02oBgnuc1MghwUp7EJT5eIf/FYq?=
 =?us-ascii?Q?YHcTLL4eZCBMK1i6BySZKL8GUo2KtYB71o5sSO3STj6KjMlHkyVZ1KyFUWe7?=
 =?us-ascii?Q?HLPgqmlxoWWZmsjezGEB0LSaBwO+UQFNUHNSSqoZLnANlBW5VTA8zL1QTZnh?=
 =?us-ascii?Q?jva3djH6GQ/Z3kDBgb1vqVkAZZjZV5Ccx4XjH+vqyXE7FlQkK17Tx/H+YJ7t?=
 =?us-ascii?Q?0bTlbq/M1WBYHYaAKlP5kElSEdjHnHa6L/jgWyS4z9i9EBTkb0OlbWiTn1dB?=
 =?us-ascii?Q?UwY/C6G6NPxQchaEs4Zf50CdwCPGaDtiVAc8VhymbKAn2BUuyX+lxtkNSuVq?=
 =?us-ascii?Q?VbalTamEx/Wct0XpohiyFc2HugyjxuCJ2AXyU7W4R6ZQHXikIAoLDyHaM6uL?=
 =?us-ascii?Q?YpfekOneOiWk0kusNabuNWhb8U1/gApt+HefpIJcMVobLzUf0X6DMx6prnh+?=
 =?us-ascii?Q?wowA9P02wxhIfRmRl1/I3gwhSvIWn7nDDfADuZ/zbynIgxogu7VAaksyccA8?=
 =?us-ascii?Q?/Pw07c93ukf4MYsl3DsYMexcOeWIopWda2fOyzAiGhTzoyxx30fyqd+WOaVj?=
 =?us-ascii?Q?M5PSuPzaOFegUAfGcBm3JExbZPPcMC+TnCPwKVS66/H66NnJRh3NIwr++5lV?=
 =?us-ascii?Q?Yw6SCUVxokTJuW1x/+8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6124cbaa-9909-48ad-6fc1-08dad7ce644a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2022 21:11:07.2024
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NB6tV03jULWHyGCDihZN7UBIe/HeC2foybO9vn9tY+n/s7TSZT+aIe+5/feMjO+96lhVSUEgmoBSh5YocM1OLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7339
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

> Add new CXL error types so that they are advertised.
>
> Quick Note:=09
> I sent out an email last week explaining why I was taking over this
> patch series, but just in case: Jay's internship at AMD ended a couple
> of months ago and I was asked to pick up this patch set for her. I also
> said I was going to add a patch in aforementioned email, but I didn't
> have a machine to test it so I've left it out. Thanks

These look like a good start. But will there soon be changes to:

	drivers/acpi/apei/einj.c

to do something with these new error types?

-Tony

