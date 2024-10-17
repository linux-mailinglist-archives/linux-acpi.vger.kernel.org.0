Return-Path: <linux-acpi+bounces-8850-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C06259A2977
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Oct 2024 18:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7A95B2D818
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Oct 2024 16:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E751DF98D;
	Thu, 17 Oct 2024 16:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GNfNF+I9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C8B1531EA;
	Thu, 17 Oct 2024 16:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729183603; cv=fail; b=glruEXv0OfHouE9Bek8aOFIfKXtVhFpouFGxjjfu+zCUNoB30mj1lQ+jLJtwyBgAoZclhZwQqePVj5CZa06G/Q/DJLzvPcX8cyHLbWqq17P8V9n1yERiLNNMMWeLmM1oMWhEnB179BlqZGryRQabj6QCovLFeUON9mGnIibI1RU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729183603; c=relaxed/simple;
	bh=TBjRykSSUgji5sQ6xulc0IsCUXMbEtrrN0sbef3rxdA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=huvX6p6ynrO4TNrFSwtiOJ9JftXZ8Jr3n1fbWV9rf7xSWX6HpjB5SqcHXKJCM2ZzdXe2Nxz4i5krDprYk7fPK1SGtlVm/cxaizoFeWfNN4x6TKiDpeQkcm8By840cOClYxZa9IzEwR3w0DILVr+DgRV1KpD89asJSM95w8nJok8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GNfNF+I9; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729183601; x=1760719601;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TBjRykSSUgji5sQ6xulc0IsCUXMbEtrrN0sbef3rxdA=;
  b=GNfNF+I9nkN4yIxu/f1qGmlHC8DJ/3GecAiwLUGHQtUcZAp0mRhJIEot
   uEwECnvuekhdw/A2Dt41oDKOmP7nqhpDtWg0QUmpYRhTDTzLWnzKTgK55
   hnu9q4zUiqwXgr3N4yIXmrVEGGbML1YpO7Pt1IcPe9rbsdDr4SqK/b+ra
   ttPgMGrEfgjxsWlZNJdfiTLGUlzOfIVmUqJlUgRisEgS1F29EYrAYSEgJ
   HyLgUh/Pb5lQaopkhLs9dSFQJfOEYkYLQZU1bE0ytRDTmERAJ9XzS6+OU
   AncjTiucCnq4C82uF6Lgzk8z6BqXX8/OLEJ8P1sjgLyIr30tjjIXfVBDT
   g==;
X-CSE-ConnectionGUID: YSSfETkMSbqbCiABqXLHDw==
X-CSE-MsgGUID: DHIFPzbdTB6mbL/qw6m/Pg==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="46177921"
X-IronPort-AV: E=Sophos;i="6.11,211,1725346800"; 
   d="scan'208";a="46177921"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 09:46:40 -0700
X-CSE-ConnectionGUID: WWDNJbzjRTWm3MMkn8opYg==
X-CSE-MsgGUID: 7xClQs/OSzas1KSBxnovog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,211,1725346800"; 
   d="scan'208";a="116048554"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Oct 2024 09:46:41 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 17 Oct 2024 09:46:40 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 17 Oct 2024 09:46:40 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 17 Oct 2024 09:46:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jeYeHSMjHu4WoGR7SRvOmT2F+f8iD9AA8NJ1tccbPdEgRw4KhzwbiR1axBjyxhOVqZab0uXVwbIGvpbBsWKYLQmmPBntWFFCa2crjXI3Nu9cplBU1gD9g9wkW2HoI/gddMXecWRmUB8APRvIPkFtj5FPFtyKEYhCJQ+D/sAWk1lUYX6YhiuDdOinMBVWPtJ/82hDJPbTX51NiZ/nR2qYcMU74Zy+us5c94OF27L9hHDw4jawWcNxOQuGIhjEJ8vG7Npb38jQjbZHHVNlfrslTaOQAwQFyI2Fc6q036bxt1X9Rc+hpWtm66A9bRxShzyfG0Fg+/cBc56WkuNOdns3bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TBjRykSSUgji5sQ6xulc0IsCUXMbEtrrN0sbef3rxdA=;
 b=c7LOrCJMDTFG5wJ9QO4Xd42nyFRJDsP4mW7WOK5mEV4KqurKiSylCJ+Pqv/OLIp6t0GTHYb2ymI9t/axT89tYLRX1CalAr2ponW1Dw7LwKWvpaMk1CJ7zVjI1z1TyG827l8ePVeRC+63v2NCHdbaK3HRYP2XSJLLOVm1QZwfsG60qFHXc+qVs9bhal8YX9v2KYsR13WE7tXOf0I4HfPLZLr3087dlosf3i59gWE1dhY/vs3CcZDfLMy+QcgzhRe0xhD8A5UEJN0ujaCgbJIKRJbpu7ygmVJH22GX4hJh7aNsQA5MgaNxUg2xffHRnLvD+z3k8Ll5Sfc14rh10CQVsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by DS0PR11MB7334.namprd11.prod.outlook.com (2603:10b6:8:11d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Thu, 17 Oct
 2024 16:46:35 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%4]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 16:46:35 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>, "Jiang, Dave"
	<dave.jiang@intel.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"rafael@kernel.org" <rafael@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"Williams, Dan J" <dan.j.williams@intel.com>, "dave@stgolabs.net"
	<dave@stgolabs.net>, "Schofield, Alison" <alison.schofield@intel.com>,
	"Weiny, Ira" <ira.weiny@intel.com>
Subject: RE: [RFC PATCH 4/6] acpi/hmat: Add helper functions to provide
 extended linear cache translation
Thread-Topic: [RFC PATCH 4/6] acpi/hmat: Add helper functions to provide
 extended linear cache translation
Thread-Index: AQHbEOiaiZAKCAimk0W7gWnPVBg5jLKLQsMAgAACirA=
Date: Thu, 17 Oct 2024 16:46:35 +0000
Message-ID: <SJ1PR11MB6083FB95773B782EA494C985FC472@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20240927142108.1156362-1-dave.jiang@intel.com>
	<20240927142108.1156362-5-dave.jiang@intel.com>
 <20241017173326.0000191a@Huawei.com>
In-Reply-To: <20241017173326.0000191a@Huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|DS0PR11MB7334:EE_
x-ms-office365-filtering-correlation-id: 6f4ed8f0-fbeb-4a7c-ef22-08dceecb432f
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?NOFLRgGjUOaBHzj+VW1KZ73Ecpg2k4CpClxi7fwJTkFby8MgYN8GWxZVlNpu?=
 =?us-ascii?Q?x3hmAtF3cQd/Shjzev2FUoAlCiGvL3PYqIOuJHWvZxnBUoz30VB8IT7YtWfp?=
 =?us-ascii?Q?SyNwoZYEu53tkmH/cD5y9ZY9b5IiTVqwGVSCrMp/pgYcYmRl4Gh7XRh1SmhB?=
 =?us-ascii?Q?P21KS60eOLZI0Wx3bCztoOgwpuwof9VZJR05qJMzS2r6j2yK0a6E71hBNT0U?=
 =?us-ascii?Q?zpeee2WCEx/kZKrUyEfTKsCTTUI/Ut0gQF0ruJb+m3JwER+IxfkzgW8r+O15?=
 =?us-ascii?Q?cVS/LgDbE7Ev4Ihei5M7tEU2IRHaS2Lz9XqpdnKTtM+5JJGEVM158rsSTPin?=
 =?us-ascii?Q?kPOFVOjRDV81FogEyiBgpyC/oU7S6eErxGgjt0isnzXCRSCVqpXqsC5H7Moy?=
 =?us-ascii?Q?mHmhNkYIAmvPVTFWZ7CmrnBUHwoWu7anXTEymZARHEbD0tNsXeigwh34ilLk?=
 =?us-ascii?Q?jwXlX80DM0t/nQlqjPR2HqLyYT1KtFgMwqkEstSqR4HHJzcuX7EPVzEqupWg?=
 =?us-ascii?Q?GuGT1QZ6zBzLVeocLEas83lj5YOzrypPAQazS3XEf0yGl6r79Qm7u4hHEEK7?=
 =?us-ascii?Q?nJ3qS3KQfAWBfBEPxVi+LTOYDR/kunUazy43B0jqYT4xHC3kYJ0KzHCatJ0C?=
 =?us-ascii?Q?KoKQN27Zyl5Z8bqanacfM1vXEaGxlJKazEIUVbBDkgsTFw4hNXRpJ8NDIjoH?=
 =?us-ascii?Q?EqvAdZ/GMgCitz2Juc8MOjxVb25M9wsczLlg1IIh6WdcLkptjuEPoGqZnwFH?=
 =?us-ascii?Q?C0WYl8PbWa9+gq+yzMB2tG0wQf16m7OibJpkueYP8oth5ZkAfm4mbTYi3lhq?=
 =?us-ascii?Q?AMv3IreP+V4b627Qm16Fu6cKDKm3xWRRLkqsMFQeGU8AqBwARfznXlbCPRic?=
 =?us-ascii?Q?coy020Queit/OMymqAeK2BW4DxIYrCPld+I8ma0gU5Xz9bwu10iDi1P6qngf?=
 =?us-ascii?Q?morSWvFxZX4Rr6HNoAJUXOUUz+OnuC22v0edjtHeWVZek2XAUv7F1jpAHrsG?=
 =?us-ascii?Q?ULLDh2phZDJKetuCS38zLuA53DKt8dDazbDLDr3fEIsjFPF9GnWeQBM6fAu2?=
 =?us-ascii?Q?hhvzHSlil3KbPVLxWgjr/sZvLrqw7FT7IODcALavxjYA1LjpWwLZJKAxXqbM?=
 =?us-ascii?Q?OUOWyaH48GvQdTHXGmmugAg6r8/tNYtaSADnptcA0itu7y6CW4NhBkTbMn7G?=
 =?us-ascii?Q?sEQXQ0+KgFgNprzJukpup+1wl2uVtqMa5uTC4W5KunGeWvNCsj3TAUwrZqgA?=
 =?us-ascii?Q?C7EU/G7bJpiYx1a7Opz9EmQbsFWzAvO5MzabSjkTlZSboGMAO467LYD1qWkA?=
 =?us-ascii?Q?dfOHd6kiHlcpmhAOnBx4TBzWoejSPfs4diOVS+jT228cLeNeCAlJwpTnvGN1?=
 =?us-ascii?Q?zioSNXo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kZSPEVZlc0KAFw1nzomvqvVoNVsOEehix7qwYeJ652hXOtScfNzQSEbImR83?=
 =?us-ascii?Q?7/gmDOu1OVFGKHm2kC48VjGLTcZb0u7RhHudNBXeAcvsgoEz91IDQrODuIl+?=
 =?us-ascii?Q?Dtl0Qk7RMjqQxuHmPNxvOVodX2vIQHSp8ZdpH18qbr928h9eq2fxPCHdZf8o?=
 =?us-ascii?Q?4nyCsiQzgOm6DRzH/io8a9aDJpADBaNBnlrTIkkWdEYsqKMs5qZ23xxXuo20?=
 =?us-ascii?Q?NGTm/jRE1JAxmgH1FfPlUiKJlDHqG1T8Jbgk8I3n0HIphaU/mt/DgsYvmD6a?=
 =?us-ascii?Q?DC2dDzrGetdWwwNjUvgtYjBdjFJekeEGwK+UOrQE6fzH7LIp8C1ZvLChGUZh?=
 =?us-ascii?Q?WDJQYO9oxuoF8SJVkSPZ6PGrchch2RtcLdd3R2HNvj/9lxDSbfJJqoESj/GB?=
 =?us-ascii?Q?Crkys2kHSNq1Z5Z5O8Jw7v/LjrOAw8dQ4hpIe+82OrMHCmrpOwXmsKkShheb?=
 =?us-ascii?Q?uvn+AgPKnAu4mSqC4XN+v+JFOXPbz9YSqNw58RUduO8FA+VP184k6svCfyGW?=
 =?us-ascii?Q?x42V5oc2jfkheIlIoeIGOHbSBAUA7BRFqpdyL3NUKC0UNaLW5kOAel7S99ZN?=
 =?us-ascii?Q?080hAcpSWVV4WZNW9S+Ot2jmJAQGLoJS2lwj3Uv9uOYVWBnF8gqXc9mMU4zj?=
 =?us-ascii?Q?BmrVaKqjSsBiULadP22YsPa/LfqVUyUxpqjjT7dEZ7LIHqgWF/imSsxVnZI+?=
 =?us-ascii?Q?SAc52sUKHf6ZUKcMECbWTcGMGXosP87+G9zgTY2cuvsL/eDHQ7d/BfX0pCel?=
 =?us-ascii?Q?Fz+5lTn4hZnkz6lS8ijzNubCN/KgAMpOzI3W447EbzToYBWCLS43jeAJxa3d?=
 =?us-ascii?Q?fWLQbySI251ZiU/PK8+ltdBh2Ug/VBF8UBWqzry9vsi+xpAe4Yx/n7sCLJUz?=
 =?us-ascii?Q?Ujqu0tCVahEnKNTvQNBiunx1p70Xbg33iwkNtMoqjmCRUtVFxmlmQP/IGT78?=
 =?us-ascii?Q?0a4Y1oZGsg/9o5S8DMJyq1PrMh2sNAKyyyzyhtIFpDfMeK0gZFHHAecWSmhu?=
 =?us-ascii?Q?IrJDQlSRfVsxJt3SINEpsWgZ0ylkMwxOecZ50jONHrTUV3iLG9NNLjN6TChI?=
 =?us-ascii?Q?AxkjtB8TxrFczJfqXo5o6nwL07HyqGnr568QW6IdSLEGUemNURAZ5cT3THxZ?=
 =?us-ascii?Q?hdtEi+L8itjX2fQLQhtumYAqATcci/5gM3zHEkDZkTHq6MqdYZYNS2HtB9ds?=
 =?us-ascii?Q?13Kdpj0J4naWAKcN8oo9gQ5LNnFzfOEPHTY7qeft8BybrnG/OdVfqyneLCFs?=
 =?us-ascii?Q?mU4I/0bxxzxh+PMv5RRicdJwEqdhlxYBWEpdt/qdaYzIa1TrtwDDd1vLfOaA?=
 =?us-ascii?Q?ETgOdueK2l7CbBHcVbybhUHMIMZPT0kKO5/3hBN+v3bCoqajRBXqMgna7UG5?=
 =?us-ascii?Q?5m3FOaRrLWOpjo8fzE4WqZ09JtOHnbVmSoYJUFwSmvHC/Jqk2JnlrRX2xmpA?=
 =?us-ascii?Q?wD9qk4Ls69SVdb54oCtawNedFHNlBbRFehipRzX2GY1Qql03pGrToFc4rK/k?=
 =?us-ascii?Q?r890rElG4xIwSQTpy+blorEJmzvWKIlx6TWPhcANu7iJQKTQxZMtKM6cvQY1?=
 =?us-ascii?Q?vM64SyA+u2T6RTJx9TB/Vq8uCDCYl1uRLcRUXI+m?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f4ed8f0-fbeb-4a7c-ef22-08dceecb432f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2024 16:46:35.2430
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9jQtX3lY+JNs2iyUKYkBD6971KwxySFDKM+pCxBSs0pmijh4jw0IK0DI4CdNkWfsItRVZLTUBhXpDzN0pbuQnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7334
X-OriginatorOrg: intel.com

> What does the I/O hole correspond to in the system?

PCIe mmio mapped space. 32-bit devices must have addresses below 4G
so X86 systems have a physical memory map that looks like:

0 - 2G: RAM
2G-4G: MMIO
4G-end of memory: RAM
end of memory-infinity: 64-bit MMIO

Depending on how much MMIO there is different systems put the
dividing line at other addresses than 2G.

-Tony

