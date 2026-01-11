Return-Path: <linux-acpi+bounces-20159-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 84EC2D0FF0F
	for <lists+linux-acpi@lfdr.de>; Sun, 11 Jan 2026 22:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E33CD304A59A
	for <lists+linux-acpi@lfdr.de>; Sun, 11 Jan 2026 21:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE6225A334;
	Sun, 11 Jan 2026 21:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="brbK0Y1a"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020100.outbound.protection.outlook.com [52.101.195.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7902E195811;
	Sun, 11 Jan 2026 21:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768166595; cv=fail; b=XKUa6rNMOIN0Qkt3AvO8bOxvl6v7u5mrTUew9Ku9DLTUWllbTBIfIqaexHSG3h/zCm1EJXZ0JN5Q5mSejifuYCfgri1IP7W6BcgDLNyotKsQWjY3S3/VfGCZOULAOx9KG4abmtFob2bf1i9S+w5mElb4Sk3EZXAlJzMfMspiXkw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768166595; c=relaxed/simple;
	bh=Y7qTRxwrv1rC0cLcr/XakryEm2P9dRzZPOnQk9hJokM=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=IyK0kmFDsHrKYfsSDBVZxSeU4cUbhULl3Lw80h3glFHgQIK69CNYRyrpO4IuUYp9+iPs2o/CM2gz/jYndxjO1QUfHfB7HamHpcGq19qEKsSL9PCBy+F6+Tkk1Z9MSXqN88ZwRiojYNiaIKJNSUFgSz10fabnYA4wpSVe2UUlkFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=brbK0Y1a; arc=fail smtp.client-ip=52.101.195.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q4T9nHw1VIEdA4sIEqVGjRf3nvGHaZKsH3aPAnTsb3wqdPO1IDmi7p4hlRilvmAUParh4pSx8dSQdJh4eMG3UIdFEip/Wo2w0zJCVvvrC6YHAdEXvaAAwp7h5/V/3nZ3t15ryUCDfUtBROytwX7M5gWGHvo/1sNpr+79Yg+joTMSWG7HGk9zitJk5mjDpiT9NRfHfF8QxzH2oNIWaBNvlCjuPkVXpFgBgTUD92zi9gMUf5Fdc9EN8MCDfNwCx49EYCyNya7B+8+wnJUWiqsolheQlQVUQ15Flsvxc8SC8EGb5IEhcledeW/1zv+BFlzmPyXcnINKJ/bBD08CP1Tk5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VFrUO0lodCSuxMAodrsy9kcoHcgeluAuhCRb/Rx/onM=;
 b=qcKNk4rJJ2zbZPknAdZXJJMVM9V3j5FqHZ39R8Paepz4K60Tnu9noVeJYHps05clcCpDTkVPreGgoCDjiYtOuAptp2FEbB6P1m5QclT1di1SJXdGieUotYyDqFiD85XBvTphf2ApNO7BbXrL51m2qaG0TUN8AJx1tnGHC258WiRTLkl18CeXuz7pWuQl0AZpa1/ToL1m6qdWX9wO86SD4bZkUZ+lxpwjiSDftPBjCcvouUsENXkf2XsqY6BSyu8eHbza+SeuaO8FyX0IG/JPZ91DO7xCMAwBBwKyEplgzlAqHVjX/qMjGrkJO9bo9NXWva10HpFRHJKruvF+0pbxYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VFrUO0lodCSuxMAodrsy9kcoHcgeluAuhCRb/Rx/onM=;
 b=brbK0Y1a7ASTCOCDQt30Male1HzkVhrq9GK3kMHlOAD5IHTTttB8/O7oXcwUNAOgpJODU/e0B/LnK2xsdld5xRCGR6bWU1MQUWN5kkiEzeNT2Jxar+OjIJ5S0TahwjtM2rdx5rZzKKqeyE8XnnDzapi5/mNXbH96jExteFiYfSo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWXP265MB1942.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:87::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Sun, 11 Jan
 2026 21:23:10 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9499.005; Sun, 11 Jan 2026
 21:23:10 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 11 Jan 2026 21:23:09 +0000
Message-Id: <DFM2QTEXNYKS.4NO92GAJ7VVA@garyguo.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Len Brown" <lenb@kernel.org>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun.feng@gmail.com>,
 "Gary Guo" <gary@garyguo.net>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 "Tamir Duberstein" <tamird@gmail.com>, "Armin Wolf" <W_Armin@gmx.de>,
 <platform-driver-x86@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] rust: implement wrapper for acpi_object
From: "Gary Guo" <gary@garyguo.net>
To: "Gladyshev Ilya" <foxido@foxido.dev>
X-Mailer: aerc 0.21.0
References: <cover.1768153572.git.foxido@foxido.dev>
 <a4bf01ed94406605e12df6b6d1676ea0bd6cd17e.1768153572.git.foxido@foxido.dev>
In-Reply-To: <a4bf01ed94406605e12df6b6d1676ea0bd6cd17e.1768153572.git.foxido@foxido.dev>
X-ClientProxiedBy: LO2P265CA0157.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::25) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWXP265MB1942:EE_
X-MS-Office365-Filtering-Correlation-Id: f922493d-2995-43e1-6ebe-08de51579ec1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a1JRdy9Zb1VROTNpa2JxT09Sb3pVNzQ5Qm0yWk5LY0FaMTlaeGluY2gvaVlU?=
 =?utf-8?B?NzI2eE9JVGJRWm1weGhoaS9NTkw0OEIxRjhUbU11Y01uYWgydStkNXRoUkJw?=
 =?utf-8?B?SmJ0OEhjVThDYXVUTVB0ck9zOWZuZFVZVHB5NTdhcDM0MlYrM3MwZ1cxSk5O?=
 =?utf-8?B?eVp6dFl5UmdBaVpSa2lBOHRBRzhPNzh2emJUSWpHdWw4Rlk2QjYya3BCU3pT?=
 =?utf-8?B?aTBPUVlBY0Q3NjN4bG5IVU9KTWp1a1Y2RDVpNWNoYmx2QVY0U1pId1paUlVq?=
 =?utf-8?B?OWdMSE5sUmRSMEp3cDBkR3I3L2tzWCsrRUoxSVZBdEpsQlNtdEwzQk9yVFFD?=
 =?utf-8?B?cG1PNlJvU1pzaEZIZXV6SWMzTmNQa1VzVkw1VlJTaSt2UE5UZEdhYjVDMkF2?=
 =?utf-8?B?YXp3Ny9TaEMvOUdZQm1lYVBxckcrREd1b0pkQ29oUDd1ZlJRRkE2TGtCSmZr?=
 =?utf-8?B?TzdpejBhTW5zTWx2aW1zUUdkWHVmMDlFTGloTWhIby9NcGlaaGVlakIraUtz?=
 =?utf-8?B?ZnVXQjJrVHNyZC9UVWJRZzNjb0RGWHNPOXBXeGhoV2QyRHUyWnpDRzBRK1VZ?=
 =?utf-8?B?bTRrRzBXS1d0L2Z2RTBUVitnRjA2Smk0ODRBVElQV2trWUJBK1VkZXE5RUhV?=
 =?utf-8?B?dG91cjZIcGhzU0JCUUQweGJVRnF2WHRzMDRWMFZXTldGMWhGOStZZmpzNXN5?=
 =?utf-8?B?OTVaUWUwYWtVdmRESjVLdEJ1TW5oZW13R1ZMeWsrWjR3dC9uSVZBSkNMNURs?=
 =?utf-8?B?azBvZm9GNzZIU0IrUVhwdXpMRFZlT21QdFQ5clBPZWtpTVFMb04rc2lhM1U5?=
 =?utf-8?B?YUJvVWZqdEM5TVNGUlg4Z2pmb1RPUjhmVUlKR3VmRkN1bDREMjgxSHNia3J4?=
 =?utf-8?B?SnFDTk5MS3EzQWRXVUZaYTFZNGtKZWNYem5KVUFTcG1LbkEybmIvRmxBcUMw?=
 =?utf-8?B?cyt5Z2FlSEU1cUkvVG91c0tneEllUXVqc1ZJT0p1bGw4aEJ4TU5NZDhsR3M5?=
 =?utf-8?B?cXpKa3VyOUFBL3kvbzlmMGYzVVVBbmJ3SlZ0QXFnMkJFVXFsN291TVlXYmNz?=
 =?utf-8?B?VGN2MTVPWkVnQ3JrcERxeUJ6N1B2MFBPNWx0WWFhczZFRWorTEdIOHgwSG1m?=
 =?utf-8?B?anRUUHI1Ykh1Q013QXphYlpBZGErdmVWOEt2NmpjdlBVYTgrSHNzN3lIZFNt?=
 =?utf-8?B?T2NveXNrSkFhSFE1WExqeGJSZU1Ldk02ZWIzTWxqRGZHVkRmWVE5c2ozSEdB?=
 =?utf-8?B?OFVZNlZ5LzFQeFVtNFpyNDkwdDMzMXczMmM1OUtZQ1F1eW4rcXRZTTRmVmNa?=
 =?utf-8?B?S0VRQkpFMkV5SzBrL0ZEOFlTc05HOG1MV3hVOFlYTHJTV2xYNzJqcm16WFlO?=
 =?utf-8?B?akh0SEpRaVhybDNVN1VLMGlISmVvSTA0ZUpDeHliKzZ6WUQ2b3IvRU41bDBH?=
 =?utf-8?B?TTNHcXJhdGVLMUVHQ3l5enIyU1NwWHF3UmhEeUxzY2x0Q2M3YUdHdWszcWgv?=
 =?utf-8?B?Ym04OU1RUStmVUNPd05ac2lmb3YxRGlpUEptVFJ1WGJiTld0ZHdJZXArUE5i?=
 =?utf-8?B?VVlnVzdYRnlxUG9hcFFRclJYbUdneGE5S2dORmFTUW5wL3BEa054bGtLM09i?=
 =?utf-8?B?ZDU1amNISWZ1OUhJbE5QdjJvUWM1QTFZR0tQb1Z6eVZTYm1oU25TWTMxNlVT?=
 =?utf-8?B?ZFlWZjhZKzBYc21qVUh4MDF1aytvbmVPbTcvQ1NkMGxjeU1Kb2x3OHlKemQ4?=
 =?utf-8?B?ajZXZkNkd0NFL09jTDh3eUt1VFMrMjF4ZlFUSUlqWXlzc0N4WWF0c3FzZGpW?=
 =?utf-8?B?MktSNDl5WFllWGk3K0hZd1lCdVk2Z284RmZkd1M0WWI1cmNmMEFpS0djSkRW?=
 =?utf-8?B?emxVYWpxOTZKQ0ZYYjlROW9BTzRYeG5ya3Y0U2VmQnA0a3ZJazMvODhydkdu?=
 =?utf-8?Q?R+RBWDS6zDFKY3vBnxn+YBPjipPX9uqr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UGpoZS9zMG9LUTh5bjVHbGUzZnN0VE5mdHd1dGFNOFkyYTN3Mk9CTldpOUd5?=
 =?utf-8?B?KzRJNFV2SmVycnhXcUREL284eUZWb1ZyS3RMUS9FSXhlWTUzUmVFamR5N1c3?=
 =?utf-8?B?bmZYVFo4UmtQSnRBenFmS2R2bUJzWVZXNFFEblgvUWdVWnRMQmdSb2k1Mmlu?=
 =?utf-8?B?NmdjbXRKU0U2eXMxUzdQQ2RRWWE2NHFvekNQQmRweTV6NjJScTEyRCs5NS90?=
 =?utf-8?B?cEVpUmNUdUlIMGJ2OVh3U2pmUDVBVFo1dkxEeGNGZmFCdGovc29UL3JDOWdo?=
 =?utf-8?B?R3FEbTdxZDI2cmpUYWVTQmdJUVExR0p1Vy9PdGRWL2xickQvalhIcE9xWU5y?=
 =?utf-8?B?T1FDNzZSVllpUFlQdm5HNmFXb2tod3pEcVZDSHVYcFZKVXQza25OV3U4aHl4?=
 =?utf-8?B?WGFWeStscUJqYjhibXU5TW5ueVZlMnptNXd6QUYxa3FxMk5XMms4VTBSNkZW?=
 =?utf-8?B?VFNSR3FDOHlrbXVDeXQ1aWVBRnMyeHRMZ3J3R002Mnc2dXVYWkVGZy80M0x6?=
 =?utf-8?B?K1VLTTg1Rmt1WG5IM1FodWNMclRqYityZ05uTDhnYkJ5NXpKK21OSkdiNWZZ?=
 =?utf-8?B?aGJsaGFvSFVHT1J6azU5dHBrejBabUQrOEJzUjlDdkJhYVFPRjBIWnlqQjlo?=
 =?utf-8?B?azlMelNsOXh0WWJ1cUs5ZE1oRW1zV3dVa0hiVWxtemJIM28wWlFuR0FZaVZ4?=
 =?utf-8?B?M04yeGV1NzNHT3daQVV2THd3WHBWMEdLZU42UmxlMHkwYXh2eGx1akNHSyt1?=
 =?utf-8?B?czZFaGVsbzR4S2tEL01xa1Njd2ljZ252a01wdjNkMGRiVXNDcW5vQjhtMlpq?=
 =?utf-8?B?YS9QSE0vODJySUQ5bk8zMDVkYitQbm55czhvSEs2TUVBZFAxWVdiZkFVWXg3?=
 =?utf-8?B?SW9xZ0crY2dTUGZ1ZDJHTEJMV2I0STh6U2l5WTA5ZkZJWUI4L2gvY0FsZUI4?=
 =?utf-8?B?RVkyR0YvTkVpK3I2NXFmQWVRM25ydld1UE5Gcy81aDduWm1EbXZwUldnRXUw?=
 =?utf-8?B?ZE8vcER0U2dKQVNIWEEzWTJRUERxcWdiZVROeFY2MnlpR0hseWxUdmt3VzlO?=
 =?utf-8?B?LzNpRnJIMFhmQThrenduV2hwdWZkejRBOU83RTB0UndGSkIvTzhmcStlVGNU?=
 =?utf-8?B?c0gvU1ZuaE9Dbno4WEIxWU1ZdENDRHdURDJSbXdtbndwbVlhajZVMmRNNWM5?=
 =?utf-8?B?Nmc4T25rT3RKazUzaGNZYVk2S0NOTS81R3JDOVBTZXJXT3JIUDhLM3VyT0d4?=
 =?utf-8?B?SHJRLzZDa1ZqM0Y1cHgxWlZvRUxFZS9yVitvM2xodWYzR0dzT0JJZXpMYkk5?=
 =?utf-8?B?ZHRPNkJsa2xYd0x2TU52dnZTUTljSUJZVHdQekxZRU84d2JUM1dwRnZuQnFj?=
 =?utf-8?B?ZVhtN3FycHVaNHlRODFQRDNQN0l6WnJ2OEpnNm9iZ3p5NlRUSFQ4cFR3RTAx?=
 =?utf-8?B?VUsyMEx1OWIvUm5sakVtZlBUWFFpMmNDb0k4SEFKVWNFdHNvcnpyRGE1L2Yw?=
 =?utf-8?B?YytXajJZc0l1a1FWN2pJcVgzWVpZdjlKN05CWFBzQ0Z3b0VDVlBPNmRSR2dm?=
 =?utf-8?B?dTd2ZEpIandlRVk0cy8vTXp6OW9vclRzQjZFb2I0SHRocTFSSkhPQkZlaDcy?=
 =?utf-8?B?ZkE4dE1nUVloRXM3L3dEV2NHUU83RWNBaXVGbWI0K0FGZ2Zod2FvVTlyTXhG?=
 =?utf-8?B?a0Vrdzd2WVM2VVR2VGJtNHF1MmgwSVREVk1nTzZYa2JySlN4WEhjMTZONmdP?=
 =?utf-8?B?TE9odmY4eUJkaWNtL1J1TnpnZkkxYUl6RGUxT2RTQ3BQL2xySmFSWGxqZ3pm?=
 =?utf-8?B?NDFDc1k5RkdpbnRIQmhQNUhUU1Y4ejhQMHJyNkhhUzRHRUpBTVNOc3RFOVBr?=
 =?utf-8?B?TkppV1BSK1RLQ3gwdklmaWQvcURzc2dmbVk4aEFhQ0g2aGExWGRJZzdwUnU2?=
 =?utf-8?B?Q1ZPdDh1eHBKL0Joc09GQ0F4OE9vUUdEelZxWFN3VUk3WUVSWkg0VDFwZHE3?=
 =?utf-8?B?cTgxV2RXQnhKdUFmaUdETXRJOWJHTXRmUVBYZ01vTGtVSnFCcXRHd1FFK3Mz?=
 =?utf-8?B?d3dhZUQ4UGsrQm4xL2hsdnpOeXZqaHZ3eENNM0kwVjIxL3hDSHMwbzR1NTdm?=
 =?utf-8?B?cDl3YkNOMlp1YTM3bFowREN4T0ltWnA5ang4M3IweExva1FKbUx3VHpmU3A3?=
 =?utf-8?B?eWl0bUZiOUxFblpCNmdOenI1ZHpEcXNKVFkvODE0YWwwTVEza2ZEazc4S0l1?=
 =?utf-8?B?KzU2VFQyZU1XTU9CVDkwaVBUbnlMN2x4cW9HbFl3Um1ub2Z6MkRGclhwTDBy?=
 =?utf-8?B?dCtJRnhkYkdzUlEwYUkzb2VvQWFBTVd6bHVmYzdwL2tUZWQ1bTRZUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: f922493d-2995-43e1-6ebe-08de51579ec1
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2026 21:23:10.1385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fo87bn74Ntn/x7k+cqzQMEXlObGDnr3Ey2rlqvqX6Mip8rzp5ZFQizDt6rPPgnRqEeOVxRHxEtmXI6Pqlt9cvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB1942

On Sun Jan 11, 2026 at 6:31 PM GMT, Gladyshev Ilya wrote:
> ACPI Object is represented via union on C-side. On Rust side, this union
> is transparently wrapped for each ACPI Type, with individual methods and
> Defer implementation to represented type (integer, string, buffer, etc).
>
> Signed-off-by: Gladyshev Ilya <foxido@foxido.dev>
> ---
>  rust/kernel/acpi.rs | 97 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 97 insertions(+)
>
> diff --git a/rust/kernel/acpi.rs b/rust/kernel/acpi.rs
> index 9b8efa623130..c730c12d3979 100644
> --- a/rust/kernel/acpi.rs
> +++ b/rust/kernel/acpi.rs
> @@ -2,6 +2,11 @@
> =20
>  //! Advanced Configuration and Power Interface abstractions.
> =20
> +use core::{
> +    marker::PhantomData,
> +    ops::Deref, //
> +};
> +
>  use crate::{
>      bindings,
>      device_id::{RawDeviceId, RawDeviceIdIndex},
> @@ -63,3 +68,95 @@ macro_rules! acpi_device_table {
>          $crate::module_device_table!("acpi", $module_table_name, $table_=
name);
>      };
>  }
> +
> +/// An ACPI object.
> +///
> +/// This structure represents the Rust abstraction for a C [`struct acpi=
_object`].
> +/// You probably want to convert it into actual object type (e.g [`AcpiB=
uffer`]).
> +///
> +/// # Example
> +/// ```
> +/// # use kernel::prelude::*;
> +/// use kernel::acpi::{AcpiObject, AcpiBuffer};
> +///
> +/// fn read_first_acpi_byte(obj: &AcpiObject) -> Result<u8> {
> +///     let buf: &AcpiBuffer =3D obj.try_into()?;
> +///
> +///     Ok(buf[0])
> +/// }
> +/// ```
> +///
> +/// [`struct acpi_object`]: srctree/include/acpi/actypes.h
> +#[repr(transparent)]
> +pub struct AcpiObject<'a> {
> +    inner: bindings::acpi_object,
> +    _p: PhantomData<&'a bindings::acpi_object>,

This can just be `&'a ()`.

> +}
> +
> +impl AcpiObject<'_> {
> +    /// Returns object type id (see [`actypes.h`](srctree/include/acpi/a=
ctypes.h)).
> +    pub fn type_id(&self) -> u32 {
> +        // SAFETY: `type` field is valid in all union variants.
> +        unsafe { self.inner.type_ }
> +    }
> +}
> +
> +/// Generate wrapper type for AcpiObject subtype.
> +///
> +/// For given subtype implements
> +/// - `#[repr(transparent)]` type wrapper,
> +/// - `TryFrom<&AcpiObject> for &SubType` trait,
> +/// - unsafe from_unchecked() for 'trusted' conversion.
> +macro_rules! acpi_object_subtype {
> +    ($subtype_name:ident <- ($acpi_type:ident, $field_name:ident, $union=
_type:ty)) =3D> {
> +        /// Wraps `acpi_object` subtype.
> +        #[repr(transparent)]
> +        pub struct $subtype_name($union_type);
> +
> +        impl<'a> TryFrom<&'a AcpiObject<'a>> for &'a $subtype_name {
> +            type Error =3D Error;
> +
> +            fn try_from(value: &'a AcpiObject<'a>) -> core::result::Resu=
lt<Self, Self::Error> {
> +                if (value.type_id() !=3D $subtype_name::ACPI_TYPE) {
> +                    return Err(EINVAL);
> +                }
> +
> +                // SAFETY: Requested cast is valid because we validated =
type_id
> +                Ok(unsafe { $subtype_name::from_unchecked(&value) })
> +            }
> +        }
> +
> +        impl $subtype_name {
> +            /// Int value, representing this ACPI type (see [`acpitypes.=
h`]).
> +            ///
> +            /// [`acpitypes.h`]: srctree/include/linux/acpitypes.h
> +            pub const ACPI_TYPE: u32 =3D bindings::$acpi_type;
> +
> +            /// Converts opaque AcpiObject reference into exact ACPI typ=
e reference.
> +            ///
> +            /// # Safety
> +            ///
> +            /// - Requested cast should be valid (value.type_id() is `Se=
lf::ACPI_TYPE`).
> +            pub unsafe fn from_unchecked<'a>(value: &'a AcpiObject<'a>) =
-> &'a Self {
> +                // SAFETY:
> +                // - $field_name is currently active union's field due t=
o external safety contract,
> +                // - Transmuting to `repr(transparent)` wrapper is safe.
> +                unsafe {
> +                    ::core::mem::transmute::<&$union_type, &$subtype_nam=
e>(&value.inner.$field_name)
> +                }
> +            }
> +        }
> +    };
> +}
> +
> +acpi_object_subtype!(AcpiBuffer

The AcpiBuffer type needs a lifetime too.

> +    <- (ACPI_TYPE_BUFFER, buffer, bindings::acpi_object__bindgen_ty_3));
> +
> +impl Deref for AcpiBuffer {
> +    type Target =3D [u8];
> +
> +    fn deref(&self) -> &Self::Target {
> +        // SAFETY: (pointer, length) indeed represents byte slice.

The safety comment needs to mention on the lifetime.

To make this explict you could do

    fn as_slice(&self) -> &'a [u8] { ... }

and then just call it inside Deref.

> +        unsafe { ::core::slice::from_raw_parts(self.0.pointer, self.0.le=
ngth as usize) }
> +    }
> +}


Best,
Gary

