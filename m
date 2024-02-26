Return-Path: <linux-acpi+bounces-3964-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E8F8683F9
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Feb 2024 23:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98C8E1C245F3
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Feb 2024 22:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB3B135A58;
	Mon, 26 Feb 2024 22:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NupMnhNK"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7EE1E897;
	Mon, 26 Feb 2024 22:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708987645; cv=fail; b=hP8xwPGrrcxY1Sp9r03TaWTLbeFTMHPs/lDLa0/CH1QFH3jl3DkMHY0ZiG1QX+fbRDSYOPjt9D1HLF6xoHaJ9ZqavdubPnY3jo1IT1a6AxTQB1wVZbL3lrOx91FKV/Z88/J1sRbOuQaJ9YJuAozm1cOW949Z/PkIfvWdls5JQRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708987645; c=relaxed/simple;
	bh=JoNO2GwKuBG1py7Yfbo4Bo+ggpew49QMzSO4WAKhp4E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ThdaZpNxDKLlh0b4zmKji/g+gUe4HBN6KO3aRprCXS2+kwJ+jUfJmUP53FhI1Rq+EX/EaQM3WC+H4qqYoTkVtBaMyZd7VF1A+YHW+9vh+qTw1MXLmVrrhr7lHQZxzWyOzhaEUWYecWufJ9JwQYyvWY6B88aQzfLxrWheIr4F3+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NupMnhNK; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708987643; x=1740523643;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JoNO2GwKuBG1py7Yfbo4Bo+ggpew49QMzSO4WAKhp4E=;
  b=NupMnhNKiKleP2qayDQSJzkuVP8Y4BKnwA8ZoHtiZhoSMzR8MNCIqJSr
   JWTd15ylyA4UQFFbNd+IibepQmFYcN1HmwIf0JMantEi2yzMZnfbss9Of
   ZdQRd988xViatl5fK+gynYNTfebBXBy3Kb6IYzQjxGWeIi+/dnZIWuwwu
   hPo04W1oeQOWdbQhBa5uXv5XKQGUYDLAM954HqzcknbXqnlucltrx48SG
   N0USqmI7JIMV6C+LniXAk6FNbrmrdBjkbdQ5FsTUyssJciGIPWdHDabkE
   FiY/5NdPpX0YxG5GLbmuymLebotV/ZNSU+Tc7R+i8p0wM70KqbrrGV1uE
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3466132"
X-IronPort-AV: E=Sophos;i="6.06,186,1705392000"; 
   d="scan'208";a="3466132"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 14:47:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,186,1705392000"; 
   d="scan'208";a="6962041"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Feb 2024 14:47:23 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 26 Feb 2024 14:47:22 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 26 Feb 2024 14:47:22 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 26 Feb 2024 14:47:22 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 26 Feb 2024 14:47:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kkmmCkVvCFC1oE1am+TQuZTq492wv9C5KvmvKfWFeVWRp22VD9813gZg8ONTfnpSwyYVvI18b6Xa3T10XKxn1LyTnqWEigNYAMTct/B34edbDi0S9T68H6W+tw+Tvpg/QaK2pUvNW8WkBpdyH0Pq6wUK40cs7gOtW0m3wEPZ6+IDKi98WEIp7Rwl5fnmuOL+TOmXEX9CM2MUObFOOLAk40EoGhM61/lHowr0eFQ0TOYJncDjiua8M1GzhcKNBKBEIToe5755N/HBI8uLqV+/uAXz7q2tNN6EzYYTHAooRafgxeNa2T+69ajoW2hU60/gQWzaLMTOA40d5Qkl7m+w1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FwC1Rp0J2xIcggMjc5rCnszDOG3ig9dDTTOyDs5LXOc=;
 b=aF6gHht5IN3mmb7I2BcYSdo3JFNVMVSz/OvYkI/973Jdo9C+BBg1Gx1bflwMnmSHHPeKvZ6U7Nqt3fOeDe4gusijGXHWaK7LgS0o/iNz/WhLCOR/jv7W+zF/RqNHRMeqP2FB6XxS6bOuourukRIWC/DnMuhcx+fyhC1dXgCuycod5hcfL8FvOV04uAMX6Z4x/I2M4jM9yEDOM4G0Jl10iKNJ++hDA48aKj5iw0TRxLVFMLLQfTKjA9vs9o6NN0y0oA+WiivjYZIG3Hp/P6VzrpTHepvKOqQMMgkrKTu5kUc/jKXINGT46TpqhIkcU+PoR4yNYUnM6EaACQAgD4pvOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by PH0PR11MB5879.namprd11.prod.outlook.com (2603:10b6:510:142::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.23; Mon, 26 Feb
 2024 22:47:19 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::d5ce:2b6c:458:3ca9]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::d5ce:2b6c:458:3ca9%7]) with mapi id 15.20.7339.023; Mon, 26 Feb 2024
 22:47:19 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Ben Cheatham <Benjamin.Cheatham@amd.com>, "Williams, Dan J"
	<dan.j.williams@intel.com>, "jonathan.cameron@huawei.com"
	<jonathan.cameron@huawei.com>, "rafael@kernel.org" <rafael@kernel.org>,
	"james.morse@arm.com" <james.morse@arm.com>, "bp@alien8.de" <bp@alien8.de>
CC: "dave@stogolabs.net" <dave@stogolabs.net>, "Jiang, Dave"
	<dave.jiang@intel.com>, "Schofield, Alison" <alison.schofield@intel.com>,
	"Verma, Vishal L" <vishal.l.verma@intel.com>, "Weiny, Ira"
	<ira.weiny@intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>
Subject: RE: [PATCH v14 2/4] EINJ: Add CXL error type support
Thread-Topic: [PATCH v14 2/4] EINJ: Add CXL error type support
Thread-Index: AQHaaQMTyYLzMSrhEkWfuaqLOd5dcLEdORWQ
Date: Mon, 26 Feb 2024 22:47:19 +0000
Message-ID: <SJ1PR11MB608331BA3F58C3E6559697F3FC5A2@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20240226222704.1079449-1-Benjamin.Cheatham@amd.com>
 <20240226222704.1079449-3-Benjamin.Cheatham@amd.com>
In-Reply-To: <20240226222704.1079449-3-Benjamin.Cheatham@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|PH0PR11MB5879:EE_
x-ms-office365-filtering-correlation-id: 6cbe33b0-588a-455b-dff4-08dc371ce38d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PdoGMnMCQycYliR3jIl+2ugKM/z3XU9DFS0XYHnm78CJKhprKkRrJ8lFq3y44y7GbXBUQe8VAt8nA813BOBlkReC17S6XxZTUJLC03O2GewSFFw3B4bWbSBG0sCPp2i72n2zEF+0U0IRc9erqmg2tRfpuw6M+ESau8DLV1h9HBUfUJu5PHQJ8QFpRtNtKrQkdvePfErpZAO9acZpvRUcvXG4W8G5Hg4FcGZMuEZmNQbVesDPfv8F61UALPR7X2exzlhwtOzNJieNk/dHSndnVNbwoZtDOHzxZZPkxtH2fPi7GFW+morVzwWADp/YOGgan/jJRHfhYhE0eV7bFMAoXq2OCprwT3WyHobZgGrSYEZP5101ecIfWxIotwV3LFHQzQMJh3oxpplBS3SALemg8cqHLcj9m57sb/eu9/NAnCicQdWm+Zq6EHfMkULupyQifBw41Bw4uIdoAjcVAVLDGXn77O0VoafYX3e1gv4xqjLB+wVEH7/ljA9LFXIp1VeZGwXXmftgClT5b0OYybrqDN+TS+h6NsO1JjsWYj12m3aTCRpRqYaxGyG055yoQqwL7uQ7Pk8DeWwp3+JblNsV3eLHSqlxUHhBzOoz8drm9zBUmDuBSyDDwLHTYxBQK6AT7TPV52yuQpPUE9DPh+QFJuu5UQiwsNuht6z+ycTF8HZgLArqxx/aV9WuJhuS3n7lPRBeHYo/Hqpt1nBYz/F1UIWP2FZdQnBgvS7XKwsi9e8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?V+eEIH4NfIFxhq+dL01GnUO7MgGvYvRtbcZb+CV6T3Lflo/VonB/MD07flgl?=
 =?us-ascii?Q?Pj3y9SWgJ65a7szEEvV5/psON0e0hrQjbRxTat7nP9w/bSlQPTBDkbQfBwnf?=
 =?us-ascii?Q?ZH6BKW9Q4Laky968bSL3unRqjlQIr6IhJIb0qBeDA56gbRcHhZHui/xEkQrN?=
 =?us-ascii?Q?+k1yqLZU6AUG/j5B6+U8SmRGbKay2voG1g23hl0PNl0m/Cvv7j3i1MTih0Bo?=
 =?us-ascii?Q?L7S7K/K2U0rYaIHB2Mg7DZVSIlEMRP0uzM7/gX2NaO3P/+/WtVM6XtyeXGFz?=
 =?us-ascii?Q?Ehg0hSZo5fOeEGnd+6+nKEqzWacQTG8jJ+punFu466tOPgF9z4vyLf5H3wE5?=
 =?us-ascii?Q?NDC61tnEHubEky9U79to0UlLIAwEfjTeYqV+qaeSEiE8WiU7DMJAJIsQs4xQ?=
 =?us-ascii?Q?YZL0V2oZ3rXaqW+1DF91H3B5Ac9hPjf7jELi0Jc1GJOmgJHVNg+k0krHOcC0?=
 =?us-ascii?Q?GUZc9ULuXjw+hc0bXOrfuLMNAqLXMw73m11GrN834S93L1DLDKMbBeHcv9+w?=
 =?us-ascii?Q?mlHDvgqpqHz0u0uOOMu+6XbOoq3olvXqRdm4zaNDoApdZOJPqLeOW4LFeprF?=
 =?us-ascii?Q?gock69eWWoMPtcsxU2T6RrT7CbweSb9sz9VpZxWhp6UDzXTTUp+VfAml3B61?=
 =?us-ascii?Q?Bpn2EjXNvJJbWAGlaoHLilRdIrOsLwWwqSZdL3w5WaXHSMZNvk0KmzVbIZUv?=
 =?us-ascii?Q?gzsvCVMBEgR74RhuG+uNrno1HPnD0JJ1m+ikUzrm0jZgc+e8nZoAKdDQR5gp?=
 =?us-ascii?Q?WuJyde3+pQZQukP77eCwWGp4v36rB1BIzFvqaD7tut2r13w9Arf3p1Y2YGti?=
 =?us-ascii?Q?kaPeUpbF0APzVmW+Muo2q5w9LWPwZOM7wRXXWJWoZUVDdn9MnPb3eUIcxj5h?=
 =?us-ascii?Q?T0OR5nzq9IUMxv9b/AFsdZZNx4C29cuYsCS5d2vechOk+aR9FZovOOIMy140?=
 =?us-ascii?Q?CMNQkzCZcUvxW+gf5S8lNfrrmDjNQpMVRDYWqACXf/x5aEiDvNmg2giLlbxk?=
 =?us-ascii?Q?UQo0/90C/RPSDHs6bisrtj/BPhsqDsjH64/Fzhd/qPZbCRtQgFKtsA2mSG1c?=
 =?us-ascii?Q?qJqa4RxjFNYC3sZ+/tUdAECOzV8KPc9nz9maiIbNxrvvj9LleTRZU8HY6zPt?=
 =?us-ascii?Q?4kMe7REMVmXX2upgRjHWtP5jxoeBmuB3FChRpvCeB3sNJwcH/RQwDt5jrliF?=
 =?us-ascii?Q?2EIDk72kgP+2k69z+b8axat3qjtxeezEN1sY+h8vDmuFUo+VVWQ/VjD9pgbd?=
 =?us-ascii?Q?JNsqh23WahXemcYdOl1Jbl0dr0E36vSGMBpWYd8+LnLW/lfcIWq0nqAsYCYL?=
 =?us-ascii?Q?2magxsQUxV1+9G0Zyj//CnBVwGCO2+RRWF3MIwK38mjgXXYgJJYI70+V4zHb?=
 =?us-ascii?Q?1QELk1+lYab2R1aZ6viABKgB6IdgMqysqr3fyvYDeDMEJSvU5SIx4ivEm/Yo?=
 =?us-ascii?Q?L/kAAopddJ2WTuJx9RQJDLVuSrTNfOrBaitSO0Dpf92vCE5bU0N2a2UAC21B?=
 =?us-ascii?Q?iK3T0PGleAQBUElXaA0ZvE7eyD95cfita9ny30qfJnQV4KVlZ6r7bbHKje6b?=
 =?us-ascii?Q?xeo91klzvs3kOjvf8nQbFe/+ix/rbMIi9378fenQ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cbe33b0-588a-455b-dff4-08dc371ce38d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2024 22:47:19.6023
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZNvvgqbjURU/JQeutvwiZZIxt5QWZgQ2bd+f/Ut1tywM/LL3UMICBOe5b78munVyRaMu4XlKlvXL92jFDTrW8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5879
X-OriginatorOrg: intel.com

> Remove CXL protocol error types from the EINJ module and move them to
> a new einj_cxl module. The einj_cxl module implements the necessary

> +config ACPI_APEI_EINJ_CXL
> +	bool "CXL Error INJection Support"

It's not really a module anymore. Need to update commit messages.

-Tony

