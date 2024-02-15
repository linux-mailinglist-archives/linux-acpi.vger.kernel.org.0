Return-Path: <linux-acpi+bounces-3558-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10553856C41
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Feb 2024 19:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC5FC280D0C
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Feb 2024 18:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5B084FC2;
	Thu, 15 Feb 2024 18:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jHEVLVz6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C53135A40;
	Thu, 15 Feb 2024 18:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708020940; cv=fail; b=BMHVPMyTprakIWosl/rjI0FX3u14t3OqfTTftty3K78f/FvlMn72SMiY28PqS8pNoPV0Kn1uaZI7BwyS/2HLTDcQ8VEGLNKodj8a0s+b9h9NDEUyAZdBjGkoXIkdDNM9zY5MTqIAYk4dXKpcaYgkKHTWpSu1KVawBobR1IKmxSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708020940; c=relaxed/simple;
	bh=lhI6ui3T2I7Pq2IXX7cA68iwbpROAr75qcChFQ6WYfA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cjdvvW0tlS83jaWU/F3Kn5aOhe/N6EEu6iWmK1yaufm+TFrZRo/ZIN+BloU0X6nHneSXhW4IdWC0Agpd1tbpttGxpaQvI7u7WRqzh1ckhNyUw8yo01N8lZP4vNu48Wyu4wqZI6qFFEGuO4QNgvl63diW9PfbTFFwOTzL4nGDEik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jHEVLVz6; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708020938; x=1739556938;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lhI6ui3T2I7Pq2IXX7cA68iwbpROAr75qcChFQ6WYfA=;
  b=jHEVLVz6oUCG7K/IvEoqM6yxuA4632b11yBcChw/gBiSAZlmz0N9jlu/
   Pr9MKTghmrOXR7Gl3L5m3iXfwfmPNRnAukMyNvzymi0qDeeEKGNGcYAEb
   CsEbzWfPnDy0pToTSH7ttHFHwW76Oc7OUDFNqI6225zmWbfnkGn4PWYd9
   mAFJMxFyNvYB8dUnNuyQZdqH07soYNOH0PeV6Ozf+7hKPNMfJ0gv7qnMz
   n3d415pWXQmFC7IKnEwn38A5AQ9ztmCj7EJAptfFVIKEFX6nAEdsBkgWY
   Vs6MvF21Lu0azrZxti939PqDftslAXQFmM8/KmPFACMrXWJT41Z7m0vsi
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="5095602"
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="5095602"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 10:15:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="3937357"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Feb 2024 10:15:37 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 15 Feb 2024 10:15:36 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 15 Feb 2024 10:15:36 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 15 Feb 2024 10:15:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TqZCB87owswMx4VeS/vHjJEHg+eI/ndQCCmsjHki8F2TIavOdcQ4Vi7roiItWQ4lmG7Y06hExH2t2zJNbBCeUJjR9G9OIZo5qQfzfvBLXdc64ou05FKCO23KTw/yrnIGte2Nt36W00qRajITarlWkrNfRu2ENYAJKJFxDPU0H6dJIe3fKxOykrP5D5hAdWABAdV92bvGGa2NYBiC9QQQP3PPzUJ0v3luPYTrXqK7EOeVqON2PgDdAR78KMcsyBiBySvH0FCcOxCXpdrpGK0uM9eI+FxQfvggLN3WcnJZ2epVArZeguNfyRWuEyJRs4YDzW0OMfrT7h5hOGGKhrmZGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+h5Jz9/7roGc/50PZ3/KP+ELk0x/YnBO6pgu+UYAppw=;
 b=DXh798nimCCh69bMphaBKOoUowhy+5H7AqarnutZVvupeAlqVZMLJDBTxf9I/MhzgZ+jEVAnjO7JR0CBdb71wr+pM7pqwrQ2UJGTPzj00eFDlOe0ZaVSehctXZxzfad/+9/94UvMO4Z/kr5Pem8aeoeR0IuaNC59qZdFNMX6+uFgiJt5nhCdUItErMbIjuxQ/gAhOkLMRHmX592yKA7Ek/ucZ0cebN4sWJO8PV4LEnV++UipYNdy16/YOUDQ5ix27ZmfIXRgFP2JrEmrG5hCxnwdESfgcQTr2qRjVrxf3fUumd+i7ozbOop7swEHxyiR8vNXHkcaRGc0B2WcK6iE1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by PH7PR11MB6498.namprd11.prod.outlook.com (2603:10b6:510:1f1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Thu, 15 Feb
 2024 18:15:33 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::7103:9cf7:fcc0:e802]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::7103:9cf7:fcc0:e802%3]) with mapi id 15.20.7292.027; Thu, 15 Feb 2024
 18:15:33 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Williams, Dan J" <dan.j.williams@intel.com>, Ben Cheatham
	<Benjamin.Cheatham@amd.com>
CC: "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
	"rafael@kernel.org" <rafael@kernel.org>, "james.morse@arm.com"
	<james.morse@arm.com>, "bp@alien8.de" <bp@alien8.de>, "dave@stogolabs.net"
	<dave@stogolabs.net>, "Jiang, Dave" <dave.jiang@intel.com>, "Schofield,
 Alison" <alison.schofield@intel.com>, "Verma, Vishal L"
	<vishal.l.verma@intel.com>, "Weiny, Ira" <ira.weiny@intel.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: RE: [PATCH v12 0/3] cxl, EINJ: Update EINJ for CXL error types
Thread-Topic: [PATCH v12 0/3] cxl, EINJ: Update EINJ for CXL error types
Thread-Index: AQHaX4F7SfMply+qm0W3UknoqcSar7EKtVW6gADvtqCAABDhoA==
Date: Thu, 15 Feb 2024 18:15:33 +0000
Message-ID: <SJ1PR11MB6083F423C85A96FB89F0F4F5FC4D2@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20240214200709.777166-1-Benjamin.Cheatham@amd.com>
 <Zc1kwWupeN9WagFj@agluck-desk3>
 <65cd7cac71377_5c76294ad@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <SJ1PR11MB60832AFF7D2F9FBD2670CBBEFC4D2@SJ1PR11MB6083.namprd11.prod.outlook.com>
In-Reply-To: <SJ1PR11MB60832AFF7D2F9FBD2670CBBEFC4D2@SJ1PR11MB6083.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|PH7PR11MB6498:EE_
x-ms-office365-filtering-correlation-id: be6aa1c8-2303-433e-bf3b-08dc2e5219c1
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dbuTsOSGJfJaG/aWnNX8vk4kG0VoeBom6Rwf3nOg0oiIrZzZEkfwcQ2flYq2zAlQPzQNMvBMMwW7loULmOHeNaIEpK2OHfy+41Vifjw1SlaQW86L1WxxtFAVQhNhCmHMLZA37M/2aLjRj+FdtWqA0AroEUmI+u1x00OumAMnuFUxCQpurVVwYVDkWV2N74ZKJEBb3Xbpq5fcM/uT5SgdD6XID1tMNcb9I70EfLxITtOeI2iUF56HjoSYlUjVKBRZ0wtfW0rSNuKZfih/qtHbqji5ATYz2dl2do3LPy9EhGbDyxZBcI5rt0wEwBJKIgJOkqUPNA7Oprml3Yv4LzONpotlfJj0JdFEKlInRR8hE4zfDnvAbqz4AmHvVBPhzaOeXlNnjS3IAHJkWFIOOE6o+RLmnYAvBzwlMdv8XQAKyF4PM9FLUHnOwQfK0tZM07TzOXI+H1dbh67Ha9vpXBU8LdbgbSM6jJsMOsegtsQfVQcMTFc98sW5sW1bC2TYVd7u0tnnyIWyu0TeRAY7LiBYRdd+vobE/RBSsktxhr1EaypcUTCRbQbLNdvd/Fo+4E0ow0ML47gkiPlWPphipq+WNGiFClOLS0oOS+SZgCm1IeFeHYbglQO9wTrkAPTHYO4r
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(366004)(346002)(396003)(230922051799003)(230273577357003)(64100799003)(1800799012)(186009)(451199024)(55016003)(2906002)(5660300002)(41300700001)(4744005)(110136005)(8676002)(66556008)(66476007)(83380400001)(4326008)(8936002)(9686003)(6506007)(64756008)(66446008)(66946007)(52536014)(54906003)(316002)(76116006)(7696005)(71200400001)(38070700009)(478600001)(26005)(86362001)(38100700002)(33656002)(122000001)(82960400001)(2940100002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zEkov4M2AH4BXNfLFSjl9r+qFsGC9oBho6D0fB7icva7h4YgzlJp8256alaW?=
 =?us-ascii?Q?21XXJYAqhtyqrZdOB+EGZa+TVM41qoPb2XZrmwQiMgOCl2ug7UzMR63JlBox?=
 =?us-ascii?Q?j87GXo0bTGzY254vIRR4+Hy41UPCmO9ruLmauSy/npu9K8Io6Z9uwoWjKa9j?=
 =?us-ascii?Q?BUhlHsuefNftBVpeZsDnsOrsSinOOyw3fsxiZk+tRBNKdRFRdK0KusogwrI8?=
 =?us-ascii?Q?Cvpkxpz2gRljXMvbAMEgkVbdwA4AnkkzBsz3nUY8Jd73zRh7bR+iIbvF2OYt?=
 =?us-ascii?Q?vESprNOis4/Aj8kD1NOcZooX8voJ+/LYH/QpbFGCBUOCsllcRzbSezz4tORa?=
 =?us-ascii?Q?/aESWu7lKuhR/fBnXIt00eLB79QRR4Rpe5yXvzUYlU6wRgk/odE8oJ6Ybe09?=
 =?us-ascii?Q?cd3bcocXGNznSKZaMNF5+jQE6rJQQeFjLB2Dg+aXOa1TFyEejyHxQD7FWF49?=
 =?us-ascii?Q?6assnMWzdgmSUj8TzOJBPNI1R3x65OIkwzX6oW/dOd7Kit+fbZdMqmaSgfe/?=
 =?us-ascii?Q?FFZBc4csv/JJhEpwQ1oG8hLuqBh7yJrzhtcW2sIosgf4Yi4gDQfd4hV2fARL?=
 =?us-ascii?Q?nT79bR6SerkRHpcQZtZ2qk0Octg25o2o+BR+BPMlW60+R7iDfBIdsEM1rXoV?=
 =?us-ascii?Q?3gGLsaKGXAZHcfVL3f6jpaKURdEWkt2ZIB6NSBncTLNTBp0qN1fuWoOwX60v?=
 =?us-ascii?Q?r+89tuWcxTev6tl9v//pcbmQL3RU9XA+Uk+nVHp/j9MjT0FbOfII3Ve0heBc?=
 =?us-ascii?Q?Tzvd+k7nX5OejMBpfK97Xr7PuZ4OllCIiAw1Vq3faVvDcS33MGlgAkXAGd1V?=
 =?us-ascii?Q?rb0DKCjikuiGnd9u13FUtkkE1vVNrYA1sTPIpf1ZLCQxzzehu1jv5dwTF6fS?=
 =?us-ascii?Q?QXg+vJtfB67Ad5k7A1bFl6XshB+JkQEL/6PgqQJM54Gt7UxKv5TE8WoNL2sP?=
 =?us-ascii?Q?ypn1z5UGMzTAimBsVongqhfuIHZRM7/pUKgmcJ0GnFKH8s/F3GZGVOAZgo1k?=
 =?us-ascii?Q?/6P3PO/KTa0uJfESGX+mwSrAqt8QW3cnz8HLE7NmLx7b2iAVwPg8t2Mns7OB?=
 =?us-ascii?Q?FvjsL7LurYAzIuWTT6lnNEWZqQjq/vAzlFQrZX1CQbpuxe2CA2WN4d2C+L9V?=
 =?us-ascii?Q?nrgoAILu38p1IG5l/542yWrJNsNeCLXvsTETNCVaJC7SpLUR5JfVxr0t7hUy?=
 =?us-ascii?Q?g1DOrQw/p27HcPzsw+HZiGVqWb5HwMbZ8OEMg4vpVxefhxHTfhAQBV7fyPIm?=
 =?us-ascii?Q?muPss2kg7dPB9ea/LqcYsxWgjxTd72i6fD6rNXC+QAM1Pv00GTXdYR8Y5nTz?=
 =?us-ascii?Q?mflvDG8f6nxVqlzewBGGPzKxkcZqYVxQXMN/aX6PvKjFEau2OYaXIMIF8Gaa?=
 =?us-ascii?Q?Z/AhlQmKMqigNVcWJhzWSkhnNQPyCZrWpizaGEM2PAlv1PEGMDzlFoSuIO0j?=
 =?us-ascii?Q?qYr86knbzkoJIS+EDFm9+SUE3yxklrEk5cP6ETCxSAzJQM6gBE1F9RGXiHDk?=
 =?us-ascii?Q?5gHYpDReBuc2kHMvqJGbNLe4v4OCqxEL3za2HD5DCNWN0hYbM0lpiW7DEsli?=
 =?us-ascii?Q?UInaay8Prhytnc0LfN1jkXspR6u7cMchGwDGVKqG?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be6aa1c8-2303-433e-bf3b-08dc2e5219c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2024 18:15:33.3787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HBoiTOP7OVxifuJxrw+qxlrAUwCpd7B+BfjRwTF7aUPzrBynr7v0bcAQthIu0G2s/XXF96f6aQ7+fCgRCPTEGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6498
X-OriginatorOrg: intel.com

> But perhaps there will be a pr_warn() or pr_err() during boot. One of the=
se will likely trip:

>	pr_warn("EINJ table not found.\n");
>	pr_err("Failed to get EINJ table: %s\n", acpi_format_exception(status));
>	pr_warn(FW_BUG "Invalid EINJ table.\n");
>	pr_err("Error collecting EINJ resources.\n");

Just tried on my system. The winner (for me) is:

[   27.989081] EINJ: EINJ table not found.

If you decide that it is OK to auto-load, I think that needs severity downg=
raded to pr_info().

Users ask questions when they see warnings.

-Tony

