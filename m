Return-Path: <linux-acpi+bounces-9120-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E1F29B654B
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Oct 2024 15:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B576BB20B58
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Oct 2024 14:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F381EF0B4;
	Wed, 30 Oct 2024 14:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="E5UtVk+q"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7971EE021;
	Wed, 30 Oct 2024 14:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730297322; cv=fail; b=RR9BFeeKThaNU5A2lc3b68OMd5qr7euNLskIkeHKUaaREIYqRX/BhvOuzs0Ed1L9A7B4XQzBS7glV9u9Mm3hAj6zKR6lfzEuLohCs0+YQzjBoXbhxRXUYwJAwhmKGht3m82NRZZHjqDBQWm2W4hXx904lHABwsBF0gIJrJ6D7nw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730297322; c=relaxed/simple;
	bh=2EVfykzGV07YTSIIQKnopaz66Jz+bJIh9Q17dZUDNMs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gcKqVa6LniNpqjUkHfJwiqzKKCgjwLBnC9aCBm/iy5W7FQ4uyssmk+Ih8vVRuNfnszM4TtkmPWO1OuzRi5jaQja/kgMUGMR5GdrN9Lsgv7V40+wG0+BQhME2BEXAO/VacEc5sBAwWBJxYWwbKzZ+qCJ83W8ITTk5/r9YhgivUeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=E5UtVk+q; arc=fail smtp.client-ip=40.107.220.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m7aD+Qh/B0tW6jXzOZToqkQyATBz6zIOKn4yURQ1Q7UTGFlAERVfFpgevgKQCgnkg+3/I/3nwIvQ+ca0OaKh5cLta2NB2XahoFkTQInVEglM64gNcN0DGS5Y4174Cresd3FZe9l34wRYFHmnGyV/XUg2vvdr7lXt2xQWO29vBMsG64RXcWUA8fOSnBR3/X4H9OdxWk65WFRSWesS8gDovZqbqCyoeo/jXOPZucQXFqv8CjJXu0Gpn55yardfH73b3WPG5Z9fYTRC+6LkZzGJj2KNqoKqfbiUvMNC+oF4RI7gNKyPooerfBlRH/jAsZ/OauaWs91v72atXqqcrdytIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h8kNaSaeRQ0PdN+B6YZFMdmV2vOF1DDuAFwlpbcvSwc=;
 b=bFAfocFLUCGhIC8xMKtFPfPrJ6vXuwKKxcV5OUFOXCSz7cnSwrFapVNFtmFyD9SkYkmAu0ZjJJzEVw9Udg7vdADZ+jD7XH45ayJGoK3P2kG0l+TJYNzWCy2LWYCYRV/7+iavSHrmgMkRMKm4gp6Qa0tFojzIsQ7qyd2gpWNzbiig0Y62Od8G3CX72XxYXeY2ldbAF/eWAHhs9YJaX3bBnKoJlE3C1LOmhIQOgZJjsQyCOolU/Pr88sgU5cZtl+OVDUgJdlgB1oyI0LB7bEgVPEIYWpM67+KdlTJMDGluKqGPs9ZtsRSojd8h87lp0lsTXOf5sZzJu8j5YyyAyf5a5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h8kNaSaeRQ0PdN+B6YZFMdmV2vOF1DDuAFwlpbcvSwc=;
 b=E5UtVk+qYFBPX5TmMmzYEXAosnS70ET0RKCbxltniwt+QJ8ETj2NgCP9FFoU+Bi1pgXVOUfO7ZWjTX9tgUu6zMwFSjKz0gOknwgvPoLj+Gl8xj4XHStgMvpb/8TNZweTTVIHEQ1+e9b7rrzu6amDY9i1x/ygekeTm/3qTS0/eaE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS0PR12MB7898.namprd12.prod.outlook.com (2603:10b6:8:14c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 14:08:36 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8114.015; Wed, 30 Oct 2024
 14:08:36 +0000
Message-ID: <30d78044-c658-4ef7-bd56-bc0badd86a91@amd.com>
Date: Wed, 30 Oct 2024 09:08:34 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/15] Add support for binding ACPI platform profile to
 multiple drivers
To: Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Maximilian Luz <luzmaximilian@gmail.com>, Lee Chun-Yi <jlee@suse.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Corentin Chary <corentin.chary@gmail.com>, "Luke D . Jones"
 <luke@ljones.dev>, Ike Panhc <ike.pan@canonical.com>,
 Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
 Alexis Belmonte <alexbelm48@gmail.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Ai Chao <aichao@kylinos.cn>, Gergo Koteles <soyer@irl.hu>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:ACPI" <linux-acpi@vger.kernel.org>,
 "open list:MICROSOFT SURFACE PLATFORM PROFILE DRIVER"
 <platform-driver-x86@vger.kernel.org>,
 "open list:THINKPAD ACPI EXTRAS DRIVER"
 <ibm-acpi-devel@lists.sourceforge.net>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 Matthew Schwartz <matthew.schwartz@linux.dev>
References: <20241028020131.8031-1-mario.limonciello@amd.com>
 <3e0064cb-b8cc-4126-aa4f-92cd4a676937@redhat.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <3e0064cb-b8cc-4126-aa4f-92cd4a676937@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR2101CA0004.namprd21.prod.outlook.com
 (2603:10b6:805:106::14) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS0PR12MB7898:EE_
X-MS-Office365-Filtering-Correlation-Id: 78fe1205-8b10-4aab-1fc3-08dcf8ec5886
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MFpwdi9xSzYvSVZlNUk0M2Z3VnQ1dU13cHVseVRmM2kxbHA2WnZmSDNrYU02?=
 =?utf-8?B?aEVLL0d5MVg0THovSElRdGg2V1dzTE4zNlJUWlpUNzJpdzVCY0VQVEdocHo3?=
 =?utf-8?B?TW1halNURlRUemtRcVV1L3lBN1FzQWVwcWNLOFBlQ09KRG5nNWpuSldJMHEr?=
 =?utf-8?B?c2ZSWUIrOVpWNTNBL3ArWGhMTXJDRHVOa3dEVHJPWUpNaW1xb1o5VlVKRzZK?=
 =?utf-8?B?SGVEY2dsV09JYmZMcE9nRStMMDROcEJBR1FRWlk2WWVyODh2RGFhOUpyRnh2?=
 =?utf-8?B?L2k5MlNWUGVPNVVHNWJLUW0rUFJMSE44NzFDNzU5MFpUUWZkUnFPVFl4aktO?=
 =?utf-8?B?SVNXL3d0ZHdCNWtGMEhFTGlWZUIvakdXYmsyVXVjbWcrZTFTcWdrUUUyQUlq?=
 =?utf-8?B?QmRiOVZMZ3VvOVE5Q1lWVENnSndYQkN3dWwzdG9reVB0QkFwTThQNCtOVXEw?=
 =?utf-8?B?RFhXdGpmd05ENFBybFpJZ05GQmlUY3JDVEZNbWlTYmYrY29WRDNQa2FteC9m?=
 =?utf-8?B?R3laVXF3SnRUTDltMnhOVjdORW9aNTFUTnhteXd0Z0JNSU9tY0sybzBiM1Bn?=
 =?utf-8?B?YS9ZVEdWZUQ3OTJrMUF3OXdGWkpraElIUVdDWHRpRTE1MlY0L0ZLZVR3VGNP?=
 =?utf-8?B?R2gwYitYRFlaSENmSUhtUk4yc1B3NkVwb3oyaUJPVHBTUTErTkVJbGd0emo3?=
 =?utf-8?B?THk5T01EWW9yRE5JMVJXVnhWMU1ZNlNaKzdLRkpHL0c4S2tUMTJoUG5PbDgx?=
 =?utf-8?B?Sll5enIvdHhHM3h5SitXcGZTZ0JDZWhGQUhlallxZ24wM2V5VVZ3NHA0MTRi?=
 =?utf-8?B?OEszeTFicG9DZkg0cHNCSXI1UkJmZVFHWmsxVXgzSlZ1aU5LWGhoRUdZUTla?=
 =?utf-8?B?RXNqUG1PbWlaY2R1YWdqT0d5amljTk0zdjZJYmVvU0RTOHl2Q2RlckRMV2JV?=
 =?utf-8?B?VllWT3I0WW9LbG5SajdCdlc3eW1tZm1GSDhYd2o5NkMwakNqZnA1Mjc2RkhB?=
 =?utf-8?B?WjBJT1ppYlRrUkphSFRkbHh6MkVhcE02ZXpPenZwSG9MNTVxQ2QyN2VLVWNF?=
 =?utf-8?B?M1ljMUdKZkV4M0NtOCs4WDZKTnVrVmdWRVN6Z3JNZ3c0K0FrcjNDSVMySzJ0?=
 =?utf-8?B?d21qbWZMY25tbHVxZUhkNmZuUEZkd3VpaEVYQk4rcUx5ZjUvRVVGZlhmNU1N?=
 =?utf-8?B?YlViZGNrRmVxY091VGl2emhCdUJMU3dzSE1oVmNVNDlEM1RwdVJ5aGpZTXJj?=
 =?utf-8?B?MEJPTlRIajFXaGxudXllVGpsclFkTFpUeVBSRlNaLytSN3doaDRKWmRUSUZa?=
 =?utf-8?B?RXRMNFZZS0NxaU9nMjVIN1VHSUVPY0RaS0xNa0pNcDRFOVNVNk11SjAwQW1U?=
 =?utf-8?B?NFpqL3JFb2NNTXhCcFlMSi9BRDV0T3o3T3dybmgxN0plcnlQek9oRmlOd3Ay?=
 =?utf-8?B?ZUNWVUNWb25qNGNPNDVWRklSaDZlbFpsazVBL3hwMGRhR2dCZWxIdkFPYkpy?=
 =?utf-8?B?bHVHM29JdUtpZVdXTSt1aWM0T1ZxeElla1FLK1d4bUJyMUhxbThpSHVlcGM3?=
 =?utf-8?B?YWhkTmJMRXQxbXBJRTJvVjhlaThLMDRBRXJzUEIyMzV6WkROTTVpZkVkTHVl?=
 =?utf-8?B?bzQxN3lEdWNWTStreWx6a0tGNUNTTHpkNEFncW14cTFTbEdZQ0pPemttUk80?=
 =?utf-8?B?aTZKbjh5VHQrK3IvcmhYUGE2bFNtSEc5cGQ4eHRsZHRmVVo2SUxQNW00WFRM?=
 =?utf-8?Q?14H4zMb43Dh232BtfHuxjY0KMOfqaWnJ3UYx6/4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QWUxSytxdG42UzVvSjVpOGQ4MHdhdkpkdWFOQnJFWStmcGllTEQxcHZDWTQz?=
 =?utf-8?B?cVVtdmNET2xZWnZ5L2JDRERYQjZSUWs1LzZURTcyQWwwNm12NXN0WVpwYkI2?=
 =?utf-8?B?REl3MExWU0ZGbndkTE1qamhyVEdJUk53cVlmYWR0NjdJWWR5QTA5MHpPNENR?=
 =?utf-8?B?L0N5SElyY3BjZmZqdUtZSHdxUjgwRUIwdFJhc3NpM1JwT1FzY2RsYURWV1ht?=
 =?utf-8?B?QmxSK2ZaTmZHQUxHejhzNFNna2lNVWZDaGhCWHdDWmJDUy9EeStMeGJiT1R2?=
 =?utf-8?B?WmV0Z1MrdUg1SVpkcHZJeFUveCtDK2JGby91QWNnVStCemx0T21BR2lJN3B6?=
 =?utf-8?B?YS9CWGVpOTBGaUNFcDhjVTZuMG9kMS9iQWF4bHZobVMyQjFGT1ZDeFVteVZW?=
 =?utf-8?B?OHA3ZVlJM0wzZlI0VWI3aXV3MS9lZVl6RUFYdUgyK1oxUjVNYXcrZmFEUVM4?=
 =?utf-8?B?QVRDekF1Qml0MGsxZzh5NDJNbXpwQXF4QlRHdlRZMnRvWGNKbjByaFF0eERv?=
 =?utf-8?B?M1NuU3FsRlphL2xLOS9sOXRXRk05MjlTMXZyVDZXOTRocGdCckdVN21nOThl?=
 =?utf-8?B?Nzc4cEVIMzhxS0Q5K3BEaTRhQVVZTXRMSldlNDdpQ2V6ZFV0bEdoVTQySnlX?=
 =?utf-8?B?c3B3TGt3RVFGN2lBVjRXVlpIWWpiTWRrMHU3Mmo2NVJFZ052c1RVN25VRlZN?=
 =?utf-8?B?RnZLOHo0emd5d2ZHWlgvSHpTV05ZWjQ3bGdNN0pSQ3U0SDZydVdiUHNCdmVw?=
 =?utf-8?B?eDBMdWxlWHhMWWRVa1FzTmhFQTFzZDVHOXpBSWFFSm1vbFFIczNWd3pON085?=
 =?utf-8?B?WUtQd2FrL05CcTZhQ2NSTFFDazZYRzJPVWFOb3EzcE1yenlkZWpCMFo2aUU3?=
 =?utf-8?B?Y2lkYjczY25RL1VDVmQwcmE4UEJzelRKcUUrY1JxbndjUTJNeGxaNEd1WVIw?=
 =?utf-8?B?eU5PRlp4Ylh4US8rcC8vTmIzb2NSMGhCajZyNk4wWmRKRThyVDZVMVNmb1pO?=
 =?utf-8?B?OTBuVCswTGVoNnRNSUowVDZKWnpXMnJHZW1hVnJvUG5qL0J4U2VEOFJvWmJJ?=
 =?utf-8?B?eUt4Q2pDL2pVWVhOZkFRQWd5dWJqWTIxNjlSTmR0bGY1WnlwSStVZ2ZKU0Vi?=
 =?utf-8?B?a3JaN3htVmJDNXR1T3J1VzNjS3ZDUGpLNmlaVTJGdUdJdmNhVG1FUVpqU2Jx?=
 =?utf-8?B?YkYybFdqbTM3TERmek1KYXpyR3IrTG12T3dIclZFNVlLVEVldm9aU2hRdUwy?=
 =?utf-8?B?dEdzRzRzR1E2UVlUUHhPTEZyY3c4dXdEQTczYnp4Q2ZubTFkakk3MnlIWUhs?=
 =?utf-8?B?TDhOaDJUOFRjZlBMVXhySkVPcFBPR05FNVF0UFJLMEJ0UXJGMEtyM1FaRzJn?=
 =?utf-8?B?cDB1SDIvV1h2ejNsTnk4V1JzclFKWW1IMzQyOGxyekdRSG8yeUJReHpUaFFH?=
 =?utf-8?B?MzhOOXRKdVA5NGVPODh1Y0VSc3drMjJLeVBYRi9TYVZyL2pVTHhMKzhMaDI5?=
 =?utf-8?B?bWo3U014L3JLWERNUGQ2Rm1UejZGVFhKeW44K0k2ZjNnT3BXOUlBTldHNm1o?=
 =?utf-8?B?RlVydkx0SGhMTytxWHBUeVZXMWJNOTBKNmNGV1RHN0h2bU1vVUJpaTFTL3U3?=
 =?utf-8?B?Zm9UcFRwRU1WcGxwT3FmTUlLd2V3aEdpMGV5T3BJWTZ0d2UwdWRhR3BDa0po?=
 =?utf-8?B?Y3g2MC90VG5DZlhSdjQwTzE4OVM3aU9lTTAwdFZLdW9keXR1c09sQ1NOdEtw?=
 =?utf-8?B?ZjE4L0NuVkpCZk81elRhTXUzbEJjV1NBb3UzZEVTVm15d1FtWE9CRnkxWFRE?=
 =?utf-8?B?eVFxSkVjWFRlb0htTlpzWlFFbVU0MnF6RXdoTVFZUW53VmtGVE1aRUFLTkIw?=
 =?utf-8?B?VFk3WmtzaFJpZ3BmdkVKZ3NEQy9JOGtDR0xIcmFvcGFibVRNMVpvOEdQVE91?=
 =?utf-8?B?bUpkc3FTamdCdFVFVHlETFdyTDZkZEM4cCtsZnQ3SlIyUUVoQUNCUTBoYkwx?=
 =?utf-8?B?UU94KzFvL1N6MVpnakxQVFVOSzRURjVRMm9ia2tKTVRORFE3bFh3dkZXeVVw?=
 =?utf-8?B?ZEQrRVpVYUdHckhXOU1ucitVSlNjTTdLU0tpam5GVmJVRDVCRDljSENZNWRY?=
 =?utf-8?Q?bAEws9/pijpHpXyFRARYaDKXb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78fe1205-8b10-4aab-1fc3-08dcf8ec5886
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 14:08:36.2630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hpt2P5oaLdHzI1f+tla/eEYrkzI0RRIyoGtE68TsDpVrHKEQz9V+t2qqyxa+djUCm/2+yUDFZEBN74s4ZL1wcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7898

On 10/30/2024 08:41, Hans de Goede wrote:
> Hi Mario,
> 
> On 28-Oct-24 3:01 AM, Mario Limonciello wrote:
>> Currently there are a number of ASUS products on the market that happen to
>> have ACPI objects for amd-pmf to bind to as well as an ACPI platform profile
>> provided by asus-wmi.
>>
>> The ACPI platform profile support created by amd-pmf on these ASUS products is "Function 9"
>> which is specifically for "BIOS or EC notification" of power slider position.
>> This feature is actively used by some designs such as Framework 13 and Framework 16.
>>
>> On these ASUS designs we keep on quirking more and more of them to turn off this
>> notification so that asus-wmi can bind.
>>
>> This however isn't how Windows works.  "Multiple" things are notified for the power
>> slider position. This series adjusts Linux to behave similarly.
>>
>> Multiple drivers can now register an ACPI platform profile and will react to set requests.
>>
>> To avoid chaos, only positions that are common to both drivers are accepted.
>>
>> This also allows dropping all of the PMF quirks from amd-pmf.
>>
>> v2:
>>   * Split to many more patches
>>   * Account for feedback from M/L
> 
> Thank you for the new version. I just did a quick check of
> patches 8 - 13 and this looks much better.
> 
> I see from various discussions that a v3 is incoming so I've
> not done a full review of patches 8 - 13.
> 

Yeah no problem waiting for v3 for more complete review, I haven't 
decided if I'm squashing the class stuff in or doing it in separate 
patches.  Once I have it all working in a satisfactory way I'll decide.

> Regards,
> 
> Hans
> 
> 
> 
> 
> 
>>
>> Mario Limonciello (15):
>>    ACPI: platform-profile: Add a name member to handlers
>>    platform/surface: aggregator: Add platform handler pointer to device
>>    ACPI: platform_profile: Add platform handler argument to
>>      platform_profile_remove()
>>    ACPI: platform_profile: Add a list to platform profile handler
>>    ACPI: platform_profile: Move sanity check out of the mutex
>>    ACPI: platform_profile: Use guard(mutex) for register/unregister
>>    ACPI: platform_profile: Only remove group when no more handler
>>      registered
>>    ACPI: platform_profile: Require handlers to support balanced profile
>>    ACPI: platform_profile: Notify change events on register and
>>      unregister
>>    ACPI: platform_profile: Only show profiles common for all handlers
>>    ACPI: platform_profile: Set profile for all registered handlers
>>    ACPI: platform_profile: Make sure all profile handlers agree on
>>      profile
>>    ACPI: platform_profile: Check all profile handler to calculate next
>>    ACPI: platform_profile: Allow multiple handlers
>>    platform/x86/amd: pmf: Drop all quirks
>>
>>   drivers/acpi/platform_profile.c               | 258 +++++++++++-------
>>   .../surface/surface_platform_profile.c        |   7 +-
>>   drivers/platform/x86/acer-wmi.c               |   5 +-
>>   drivers/platform/x86/amd/pmf/Makefile         |   2 +-
>>   drivers/platform/x86/amd/pmf/core.c           |   1 -
>>   drivers/platform/x86/amd/pmf/pmf-quirks.c     |  66 -----
>>   drivers/platform/x86/amd/pmf/pmf.h            |   3 -
>>   drivers/platform/x86/amd/pmf/sps.c            |   3 +-
>>   drivers/platform/x86/asus-wmi.c               |   5 +-
>>   drivers/platform/x86/dell/dell-pc.c           |   3 +-
>>   drivers/platform/x86/hp/hp-wmi.c              |   3 +-
>>   drivers/platform/x86/ideapad-laptop.c         |   3 +-
>>   .../platform/x86/inspur_platform_profile.c    |   5 +-
>>   drivers/platform/x86/thinkpad_acpi.c          |   3 +-
>>   include/linux/platform_profile.h              |   4 +-
>>   15 files changed, 190 insertions(+), 181 deletions(-)
>>   delete mode 100644 drivers/platform/x86/amd/pmf/pmf-quirks.c
>>
> 


