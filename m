Return-Path: <linux-acpi+bounces-20665-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Dm+IpPTeGmNtQEAu9opvQ
	(envelope-from <linux-acpi+bounces-20665-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 16:02:43 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F987963D0
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 16:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E8A32316C8DC
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 14:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F3E35CB68;
	Tue, 27 Jan 2026 14:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Bw0vUH5K"
X-Original-To: linux-acpi@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011033.outbound.protection.outlook.com [40.107.130.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B68B35C1B7;
	Tue, 27 Jan 2026 14:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769525259; cv=fail; b=NQyNs/LaD1spNtcfS58Gdtfev5FgOyQCgj3wY3mQX2UdtlsIRtf8Ud+03ikhs3Snft8p5dXIuEEQkDC/y0vntxKZpHsW5XELsg2wSked3KEayhZqJs+FXbfA40FzvSKd9sHLKHUAWIVX7d1hlyAqNagkTATuMDJ4BWECvfw3k6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769525259; c=relaxed/simple;
	bh=vBTxSr5WtDtAjqr9jxhmwOM05zdC7AIZddPTpZpATUs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NX+3LV7mg6uU5zQZDHmSYPOMzl62kTHtU3MSnXjTFtJv52UlwTlYaTX4lBqFMgBhK1BzTX3l6usYUDoIyOipDpoH4rmg53kRzTmURi3Ktgd7gGhzoJ+ZBh+rmP8plcIDE3JIUczvAueZwM7dfo6gjfshZXJq3r+D9PRuHsFFFj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Bw0vUH5K; arc=fail smtp.client-ip=40.107.130.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ti5oPHWak+4yeW4Uxr1CnqU74p4SD8YL1M8yKrk9iy+M46o1giXwnwC477A0O7ZqLjxaIRNXhJ6CABJODqgLeF7FTZDmO+shIWCaHArMSaJvShC9nb3kR0F0ITGEpjuS5BCkHgwxcyqfkxOootvZG5C3WMAR4X/hVhcM9rdIK+GTDD5iRSklT4Q8m4YCwid5RJfHsrdmsXRCfMUZtBVaRjbN9UZnnvwhLZrM8yamDVhafEssq6caX7EpcX0gkilcCB19sbzSnnBbcR6crzmthHV7TyoZoMOWAMsG41edzfC/Ey1e7Pxl/pTULrNYwnsw+0Enst0uUlWj0BeoJhIvsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XLqJoK22m81K6EdO/wXERFMviAD5A1q7WPnwET05YmE=;
 b=yROgaR+OAakVCrksfd9YWrgFrLtP257VIRgvQz1gWQrBOkuNJgRec91zwb1m5jmxO1FYjJ3qe9arx6xBQ+xzlZwfoQ+gcmsBHHxnWuUCDSjZp+dHCH0Uc0yOYfIy71Mr5b5OBepfODsZI4SI3BHErZmmRYUldMlPQWR6MzABuNC0Pms0ziT+L29CXNpMxBCy/qxSZRR+fRCRIp68OyEEqAWuPimDC9w9Jar7q/fQAJik7SdMYuAPbDxdzhAyv+8Ps4z1eddOLOumJQGi5jg7vp+4WesWXSkASCsN3wILu3jJCyW9c0PWYPiiesxeU5z/8+7DJYnoG+DUl9BqNL9t6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XLqJoK22m81K6EdO/wXERFMviAD5A1q7WPnwET05YmE=;
 b=Bw0vUH5Kzi7ZzC6bLRyvnLB6uhDxFB8/H157Cu2ixKyuCvba5tzB9Kocby1R0UB/z+/+etUFwC1CJmwyfHmd7syjdA++IDPjZWAlAK0NFswx1E0YEFiXAVUs1JuDImXrXEnvgIYk9TMQR+/ln7mkVj2g+5SvfTZNaJKM2+l880ZLXyN4TQc4rpJ+f5hdlHH3Lv75LevDVuR8CbBuLu/f0T4O8wp5dcURETuFrhYNRS93jTVzU0mCB/GlH00nzP2nFENH1qhyEdwsXDT0v/E2VtAqIxRDUvDwOebqDB4p6VVLaOJ0L70NAAzHHanndZELJS2iBH1i4nOHu7oZC8cvBQ==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA1PR04MB11508.eurprd04.prod.outlook.com (2603:10a6:102:4e0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Tue, 27 Jan
 2026 14:47:33 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%5]) with mapi id 15.20.9542.010; Tue, 27 Jan 2026
 14:47:33 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Peng Fan <peng.fan@nxp.com>, Sudeep Holla <sudeep.holla@kernel.org>, "Peng
 Fan (OSS)" <peng.fan@oss.nxp.com>
CC: Jassi Brar <jassisinghbrar@gmail.com>, Beleswar Padhi <b-padhi@ti.com>,
	Andrew Davis <afd@ti.com>, Yuntao Dai <d1581209858@live.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"mailbox@lists.linux.dev" <mailbox@lists.linux.dev>
Subject: RE: [PATCH] mailbox: Clean up the usage of mailbox_client.h
Thread-Topic: [PATCH] mailbox: Clean up the usage of mailbox_client.h
Thread-Index: AQHcjxf4DgFLbEkKB02YPJvzs0YZjLVl3e+AgAApT6CAABInsA==
Date: Tue, 27 Jan 2026 14:47:33 +0000
Message-ID:
 <PAXPR04MB84597C134FA912B4C929E11D8890A@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20260127-mailbox-v1-v1-1-cf15d7cece48@nxp.com>
 <aXieA6vpJEUvEKRe@bogus>
 <PAXPR04MB8459042676EF3E77D71C19428890A@PAXPR04MB8459.eurprd04.prod.outlook.com>
In-Reply-To:
 <PAXPR04MB8459042676EF3E77D71C19428890A@PAXPR04MB8459.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|PA1PR04MB11508:EE_
x-ms-office365-filtering-correlation-id: bce3451f-2531-4596-7ae1-08de5db30151
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|19092799006|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?RR3rvbX6jFErXUxEonD/Xw7EZnfVjZKGxaQ1keGd/uFLcnfpf+TJTKS94s5Q?=
 =?us-ascii?Q?i9EdxgIKR5TUdBWepu6HvWaCe4/GqrvQNTvyV3QwOwuu3VTesS15/2p56JCI?=
 =?us-ascii?Q?7Mg+2HBSP6qDOgpv+fn4rpYBw5aU/TXl9JO8pg/NlhGBPb0Y4ZKA/2Tzjqc4?=
 =?us-ascii?Q?Ozaai4+uTHmIK0YvUZ1rkUB/FPynST1Vuhqt5OJ+mw2xEi7Z/YWkKdheehXO?=
 =?us-ascii?Q?LpDtBCiNgwPh7JRGRQbNx3ylkEqnW17b+LiMAPtOuMdDCVLMiHmWmnlG/T/r?=
 =?us-ascii?Q?pY8pvyMnqNVittG6yE3GTd5VJMSG12yOn4DY4gTmMcnAYLuY6dp4P+587eVG?=
 =?us-ascii?Q?U+mbGDCdWjzTZCQmaCMSzSt2FnH0LOLDjBcAmsquk64UYckEnvu6jnKwKlpA?=
 =?us-ascii?Q?6HCxV/2qaNLJWce08ngUWieCORTWG8igrl1rdd/EjSsfy70LdNnLK4p8288N?=
 =?us-ascii?Q?hDQGoMTF5rdtCSgHy/KO9OmsJYxa97KTWx82tOy+MW8fcB8hAWXOjEumKgNQ?=
 =?us-ascii?Q?6XUovybB0IeQanQNvkR9Rei6t9+fk1hE4j9wml1fQipP2H71u/6mqrvu4zru?=
 =?us-ascii?Q?M4x7Jmgkp92SkSUJ7nDIOIRkvufLjGg5e3YxYzEuGnaX5CnmjYr4Cdf0oFj4?=
 =?us-ascii?Q?TMP4tZUlyj9Pcrn5UjVWPBBGuumKsR09k3z0wetLe73XYqMBnAASQ95dkyUN?=
 =?us-ascii?Q?qUh9f6OmsMPqGe++LG7TcQ2WRDcQ5vxLyI5R+UYASYiQsiMPpX8X2ShWqYnG?=
 =?us-ascii?Q?zw4KMx0MJ/pcQFw0wvHqJ7TkKXEgKA5VCqH6Yf8cJRYmu5txjxVD7A+E9ylc?=
 =?us-ascii?Q?WdgOK6ywQy20UXKY1kdLksLqdeW/XqgxHwNV5tRWIvh0dM1iKxjC5e+qwKdn?=
 =?us-ascii?Q?f/lcFYNKs0Q9XDbDrzrbsK3Lzu+ioLoyk1d/tC7e7bH795pLftDaCVYluJWV?=
 =?us-ascii?Q?AOYi7iCGsGjJDlxKZYtMJ11i4AnKSj1ekt1pxf+JQkGlQt7Z9QBCwCXMbppI?=
 =?us-ascii?Q?DM91JUv4di/RP2fux4GmhDyEwK2HvGuMw7XdrmBwcxz1VKDg8FWZLpumYL+E?=
 =?us-ascii?Q?neIcPsDhhe3dojSV3qYxz6JBo2qwfu57ISjR67sI2SoFN1v+jQyYuhZgRTuj?=
 =?us-ascii?Q?HxH7G3RRAf+gOZfWoYm4HNIm0owZNuoYMdErZX8C2pEnqnjYWqA69zo/8+XK?=
 =?us-ascii?Q?+TQyMNyi1y7jW1E6KzDZ5NDUPyGtyqMHqWp8fM/MKNI8rg4FXvA3BsNKL5RD?=
 =?us-ascii?Q?Yd2YwN4ghkRZMeqJlSxh0pt9e+parpWgGNqkSDhgVQNdYa2U9wqjku5wWeY8?=
 =?us-ascii?Q?QMvKBWn2/UdSyBeO2mmPJSCk2/7wTU5+LZrhDQb9ZU3+qoY9odzqFtYkRCj8?=
 =?us-ascii?Q?9Jm3jonGoR9YZKVKOAj8hrUFUiqJ1DdNxtKw81a/ErIrc0tmqWlVlTB84Bkf?=
 =?us-ascii?Q?MaTMaPJfuV6Hs3ZyINyrNN+/hT5d3aMxlErQnNgzC18g5m4KGDRCfWZMf+fG?=
 =?us-ascii?Q?gMZgPGP3HRm0ObATxtpPQvtv6bnn71YchiJwh1uvfIZ83A665Z6z7xToxmc1?=
 =?us-ascii?Q?oTWw6o6p5ydG1tU1nb8ILpm7J+Yi/U1nzumTZKlvqaiViXQXNAoip0eaGBHY?=
 =?us-ascii?Q?2JIuB1uc++Lg2Rb4lJ0Yiwk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?1EkTULqrywS1zoMOtkRTNfzI8qOKMXLmv0FA4NnLZFZF0w9jspkfxeCu8q7C?=
 =?us-ascii?Q?CaRyGIsMlLKaGz3etgCupyiN+NVhM5MCIstPHFf8jcY3f877p/wPKk0gUHnl?=
 =?us-ascii?Q?Wq6011udzn06oCN0xzfkKZGtr/TEiCjqgWOGSnR+qfBgRKIzbE7LkELTMDWR?=
 =?us-ascii?Q?xdrcs9K8NRz8ZTtCc7k2vhFV5O+2hoTUdi9ntAqABZb66/ZNiNA4Iz3aQYy1?=
 =?us-ascii?Q?7YYEwA9HBtaocX5f/RtDKEpdT/eF/Ma1VRvcYD9G2Wd7jYSfiSIfuD8d0ye3?=
 =?us-ascii?Q?QhJNqpSPncGGioT7+jt9XyyPCAWiB9C+mdetpFDqpxH9MGkZvNkgqlkND2eN?=
 =?us-ascii?Q?XtRDYGXPKND/yHdC36kKaaitVxd8LPHr+9qvE4rS9pVow47Wo2j8fwVgS8Fk?=
 =?us-ascii?Q?HOERFJYSBqttHZbg7WVB7OSMT8fd3gVVLLGbNiXDfkUmRnw6hLhUZwpSalu3?=
 =?us-ascii?Q?fK2UDnq3vcvewfLeeQ2vDa2kO7JAg3SnsSjswxI+VhLSR8aeQVw9ZLFbn8LJ?=
 =?us-ascii?Q?1lraiGJqaIuunDFsv/YSCBrsibln+xhxJqTRuNNax/5ry6p3UrzG3FeSVnG6?=
 =?us-ascii?Q?Vc+DHSG+0uCw9aq4ScUkjg0eWDOWB6zIgZfNzHRHdsTGfydtvRGsbL21CmF3?=
 =?us-ascii?Q?lD39DVBifPRfRSFE9agVdF9y4RlEypmCVJl8q+X4R/wl2o+aodc8fje6GqY9?=
 =?us-ascii?Q?RXQn2tKOXBM6sWpzyLZT+yw4mi+gVWK4N0REkbio44MUPWKbXDL3JTIz65NX?=
 =?us-ascii?Q?UuKsSp4h1rBd9HNzHJmaHUCJwZjrTmTVXcn+BILSEORxeOwJHxly4VKLE+J/?=
 =?us-ascii?Q?X/UWPYRpkKMLU8T6EGf+wyJ22RABMMdgmP2B1f6wKyhqSwWoU4x1ivBCTuRW?=
 =?us-ascii?Q?DVVAIpBO5DTdYNPNMsh9RTYOOKARMLL2z/HhsmZn03SYE3SXnAcy0fPdvOxO?=
 =?us-ascii?Q?gQejhxEYcWZwSsYMYOmfHlVwrqWu9BM8Dm0JhX3rwdBZCpv901gQT0Su2twc?=
 =?us-ascii?Q?z85P3/CciceM9UhZa9KtekyCB3LQuEWKG4BOHBdySGc9rm9XPCwcPMD4e1nb?=
 =?us-ascii?Q?LhpNCAu7oCr/HpEZRZeGJgoupwXrLGOuXGAe9ED0xFnoLcp7bAm6ZgTgTK15?=
 =?us-ascii?Q?33La/vk4j3za3X0zGlyK0cDK33sYTTAO8c8lU4KWgGGzV/vBGxpYrUXicV5Z?=
 =?us-ascii?Q?yArqh4+bWNqeKnT561A1lGZNeXt8F+bIgVt7VT9DeT2nTHA/F4B1JjE+gp+F?=
 =?us-ascii?Q?N52+7J0kGHEayK2GFXy21Z9k9kWKDtsjEx512RK0X7uJCermdbV80MPn64h4?=
 =?us-ascii?Q?ZDKe0hVIl62GBHiuggiAe8uXFjiWvI8A/W0jbVsjs+/oGGgSvUnKIHR6Ud3c?=
 =?us-ascii?Q?CNNwF4O2TyKpTmc0nJ+0/PudxWRtyS1V+rcW6of25xZ3IWHl/4Anz24ZecrQ?=
 =?us-ascii?Q?OzexhiTeYQHK8op5iahH9VbP9YEXBI2bEJv+5kfpvn3TVbe6gRd0dtOHRY3o?=
 =?us-ascii?Q?th6gKbXUkkJlxgSWLBM+meW4Rb9qs3Lr/snghkiESWwI6uo9yYWNZcUe/++y?=
 =?us-ascii?Q?ez5+YZ5+uQ8paZZ+PzscmnNOIRr1otcAPx7UnmCtZvGb09aHc9f4l9pqjB1g?=
 =?us-ascii?Q?+nUWWPzRXMBt2P9JTl5Gz5+cxYpI7tnYLN3GspIPq4n5V7cGYxaQACWKGr47?=
 =?us-ascii?Q?+rMW6UEjBS53RK8uv8KkfG4kV3aP2UMAmY6ReeEbJmAU7u/p?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bce3451f-2531-4596-7ae1-08de5db30151
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2026 14:47:33.5272
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h0Tp6yiIdXo2A8VuLSAiPgJM7vRRomSXMfm/qUsaxl6Ek7+96gdbt6tLlwFVMe+F9i7jOsKV7H0S09oPBBim8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11508
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,ti.com,live.com,vger.kernel.org,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-20665-lists,linux-acpi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peng.fan@nxp.com,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[PAXPR04MB8459.eurprd04.prod.outlook.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:email,nxp.com:dkim]
X-Rspamd-Queue-Id: 1F987963D0
X-Rspamd-Action: no action

> Subject: RE: [PATCH] mailbox: Clean up the usage of mailbox_client.h
>=20
> Hi Sudeep,
>=20
> > Subject: Re: [PATCH] mailbox: Clean up the usage of mailbox_client.h
> >
> > On Tue, Jan 27, 2026 at 07:02:53AM +0800, Peng Fan (OSS) wrote:
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > mailbox_client.h is should be used by consumer drivers, not
> mailbox
> > > provider.
> > >
> > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > ---
> > >  drivers/mailbox/bcm-flexrm-mailbox.c | 1 -
> > >  drivers/mailbox/cv1800-mailbox.c     | 1 -
> > >  drivers/mailbox/omap-mailbox.c       | 1 -
> > >  drivers/mailbox/pcc.c                | 1 -
> > >  4 files changed, 4 deletions(-)
> > >
> >
> > [...]
> >
> > >
> > > diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c index
> > >
> >
> 22e70af1ae5d14e6e8c684fe032c2864f6ae4d6c..6ca84596e7637114f6
> > 6d32a95d12
> > > c863e942b756 100644
> > > --- a/drivers/mailbox/pcc.c
> > > +++ b/drivers/mailbox/pcc.c
> > > @@ -55,7 +55,6 @@
> > >  #include <linux/log2.h>
> > >  #include <linux/platform_device.h>
> > >  #include <linux/mailbox_controller.h> -#include
> > > <linux/mailbox_client.h>  #include <linux/io-64-nonatomic-lo-hi.h>
> > > #include <acpi/pcc.h>
> > >
> >
> > There is a call to mbox_bind_client() in pcc.c that is declared in
> > linux/mailbox_client.h
>=20
> Thanks for raising this.

Check again.

include/acpi/pcc.h includes mailbox_client.h

Regards
Peng.

>=20
> >
> > You didn't see any build warning or errors with this change ?
>=20
> I not see build warning or errors with aarch64 yocto scarthgap
> toolchain. Log as below:
>=20
> ~/l/linux-next (b4/mailbox-v1)> ./build.sh
> *** Default configuration is based on 'defconfig'
> #
> # No change to .config
> #
>   CALL    scripts/checksyscalls.sh
>   CC      drivers/mailbox/mailbox.o
>   CC      drivers/mailbox/arm_mhu.o
>   CC      drivers/mailbox/arm_mhu_db.o
>   CC      drivers/mailbox/imx-mailbox.o
>   CC      drivers/mailbox/platform_mhu.o
>   CC      drivers/mailbox/pcc.o
>   CC      drivers/mailbox/bcm2835-mailbox.o
>=20
> Esp if
> > build as module.
>=20
> CONFIG_PCC could not be select as module.
>=20
> TBH, per my understanding, pcc_mbox_request_channel should be
> implemented in consumer driver.
> drivers/mailbox/ is for mailbox controller.
>=20
> Regards
> Peng.
>=20
> >
> > --
> > Regards,
> > Sudeep
>=20


