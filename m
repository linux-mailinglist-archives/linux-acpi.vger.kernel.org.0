Return-Path: <linux-acpi+bounces-10343-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C111EA00098
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Jan 2025 22:25:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACAA23A2CE9
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Jan 2025 21:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8FB61B85D2;
	Thu,  2 Jan 2025 21:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="q4U8BSID"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CY4PR02CU008.outbound.protection.outlook.com (mail-westcentralusazon11021093.outbound.protection.outlook.com [40.93.199.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27CD1420A8;
	Thu,  2 Jan 2025 21:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.199.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735853096; cv=fail; b=oyuA2ns00VwIT5ffN6olYCG5GY92iGwC6cSeTQLrwhyDqFQh/vWVL4QvFMtry74vN6llW6iXIeKNm51VciAwUcLEYX8fBbXC4MQcmqG5qjl9IokrOuLs5rzNcJjxCYPjwOp7uPsu0XRWidBq0kCndRBOSuPY7HekFA965LmcXUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735853096; c=relaxed/simple;
	bh=u+jnxg5VcAWgRRO7hTJ2PvccTBuj33toymoC7NVwOrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iieoNFy9AfegEh9CKSU2oMvvBiaKqGNtzX2GUryOHlKIzGSRq0SzmSHCvmySiC3qoiSAnfeMZvDAvW7RmbcUbhifkCID9Y8Uq7XxyX4dIJtXWVvyKXds/qxPHaEZlvGLmnxOFA9icI0nHx41CEY1jlG6AMz/EzIii1lxJbHb/zo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=q4U8BSID; arc=fail smtp.client-ip=40.93.199.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UhFujlKH6OByIXueabvUipNVUYqhysFFT/XhvQey2vLNzxAMy4BipxF/TsY0EjQv2x4jRycDgadXW9Pbprvn4DwwnsJAlREqsKkZHcH/xDucqI63FyRQv/FHFeSGCaNTYAACRoNn7S0C16WkuFxOiG40YW+WKOJMxIyLvMN5J4z0QuyZUwIhm4UOUzoPVZOOYAFlwU5kjB1wiWKvc+2kHsFLiu81+F3JVXEI10HHDwilk4Uqe0zp19IA67pkwVhsX3GEHA2tTpcg61RtN/ZX8iiGb/ZnGrLF96hbiyEnSBcMlQaXJqZ6dEtXwK2rsrt+4fSxrVn9y5tIoJ28c1mGtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gbFj8pQO5yi7kz4NAjznEK6KENq5UhsMpNxfFS9XGic=;
 b=n4V/RFG7ZC34JDV5SoxeN26FbfYBLo48Gvgf11UzrysOBCVNChzH+TcCd6DFYEMRQI0oYipvjAm09djbmTJZgBQ5eWNSpWlJPJgMGBiiH/tN9iNRuEFnZuw0wOei3vheK0NNVnv5nOS2anaN34oarrUGAlZr4wS0ARkfZ4kV+oJbznj3GW15sQXFFm8BQDdsiV4vXgrr81Z4BMcjxaRuM6YzKG9M2dka1QK6TAWNXQPIiEYWVkp83f2XGWY9Grjag9TceR+dB+H9yIZwZv4sAPs12Ladc3VEKahtC59AumiqfcfYrRT0pIFPvGHryu+/xzKJc/4ucqpgBNPZi8LJ6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gbFj8pQO5yi7kz4NAjznEK6KENq5UhsMpNxfFS9XGic=;
 b=q4U8BSIDkhdvwCLEHP7f8Uluqi3miaFvkghO7t6WkL+u30yA7QM7F/x4EdYlPnBFBTKVrDXALBI774L571XMMJWmjG0/Exo8LfvGR4w1lVb4EVfCRYPp6ML3yE+0rn+QWjmjgqkg3MBqj0aAG+L87hMelAWi0IcyAufEu/+bqQ0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 PH7PR01MB7909.prod.exchangelabs.com (2603:10b6:510:277::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8314.9; Thu, 2 Jan 2025 21:24:47 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%6]) with mapi id 15.20.8314.001; Thu, 2 Jan 2025
 21:24:47 +0000
Date: Thu, 2 Jan 2025 13:24:43 -0800
From: Zaid Alali <zaidal@os.amperecomputing.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: rafael@kernel.org, lenb@kernel.org, james.morse@arm.com,
	tony.luck@intel.com, bp@alien8.de, robert.moore@intel.com,
	dan.j.williams@intel.com, Benjamin.Cheatham@amd.com,
	Avadhut.Naik@amd.com, viro@zeniv.linux.org.uk, arnd@arndb.de,
	ira.weiny@intel.com, dave.jiang@intel.com,
	sthanneeru.opensrc@micron.com, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, acpica-devel@lists.linux.dev
Subject: Re: [PATCH v2 3/9] ACPI: APEI: EINJ: Fix kernel test robot sparse
 warning
Message-ID: <Z3cEGw0qFqj8peoQ@zaid-VirtualBox>
References: <20241205211854.43215-1-zaidal@os.amperecomputing.com>
 <20241205211854.43215-4-zaidal@os.amperecomputing.com>
 <20241224152855.000044d0@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241224152855.000044d0@huawei.com>
X-ClientProxiedBy: MW4PR03CA0154.namprd03.prod.outlook.com
 (2603:10b6:303:8d::9) To SN7PR01MB7903.prod.exchangelabs.com
 (2603:10b6:806:34f::17)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR01MB7903:EE_|PH7PR01MB7909:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dac1870-45ae-444d-5f9e-08dd2b73e1f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QoQQJ3805kGM7A1wsenPubV5D1y2uR8X5sFcYRYtrD5GzpiHW2NggSEsVXav?=
 =?us-ascii?Q?lo2tybvNQZWZiXD98YX5cciYOr4XVPA9UhpvaDL/BLd7d0p1ZaEq1EZ7Riax?=
 =?us-ascii?Q?sIMyMo27mYYYXf5VOr95eU7SINMwEoa2wAWg1PeSqTDgzl9AA70yHMk0AZrE?=
 =?us-ascii?Q?fF9+3US9zkGvGsvfploeH3ocguBByv8lwFIjJ/YhKAfD+TuGGGYNqDWupwZS?=
 =?us-ascii?Q?dmHwOFoip/ZAAsHbV8j/hzkSVTobVTZH/W7DkE7azE3N+YtQFtHC0U6wRggw?=
 =?us-ascii?Q?O9rTDaD/DgeX+uCsjklfJvrFQJZyItEnwjBbsHMXXwLVutzUHwKBiDXt3mzO?=
 =?us-ascii?Q?zQXmWo9qDmdgpcdn3YjyAFpwrAk4NnKUxmbiDjOHO/gnkJmYiWS4tQ7oXkMQ?=
 =?us-ascii?Q?aQF9eNPmXIg2xjdojJlMmmeJAh7RWyrLtTtLd+L/fuHSYckS4uQMjw7Rotsl?=
 =?us-ascii?Q?9lSXkL7BTrTzpvmqCy15/GXYs7kxuG0nbgmw8lLZHnAWlOtox1ZwT3aMsXio?=
 =?us-ascii?Q?zXAcMdNLEaR4ucqTc6cCne8SbeaXWOZ8AHrrasHpkZouJj8vabpcqXrwdvNh?=
 =?us-ascii?Q?MfCn8QJxWeYugYdHIRNEs9dPkv/R8vvSSPLEM/FxEQ5q8DIqLsULsMSkKHyq?=
 =?us-ascii?Q?Fm56r9fA3hnTZIiYbcM9S6dCTfhVXUWXVTXhEq/g27IzmhoC26qR2JJOmf9O?=
 =?us-ascii?Q?jY4tIX+VRdHeTv8d7wMpq+g/iQthky8jFRJBLeesmlfkZtfhTm0Nr+h/L8Mz?=
 =?us-ascii?Q?+0H34r+zPL2yLAH2+XW2nnbILiZCCQOQk54YzmtjsOg1apelq+v8nZzFqCyY?=
 =?us-ascii?Q?3E2d7xggPzzH6Es3TufezA5x3BRLpMesV8uyOhIp8/bLHSqIjjntSKoWrFRl?=
 =?us-ascii?Q?xyqkOX94TwXB5MrgFN+lNc6TtGN5bnjnw59wpon7GHhfn0Iiche1nm8g5Bus?=
 =?us-ascii?Q?eNsjKbJ1jeAFCKwxwrFaGJir3cGX3DwWSbQ0zq7y5oB8FF3RosjHk0A7XxF1?=
 =?us-ascii?Q?RtsJDie+Cr/qdgATnpmfkrG+eeWcCs45sJJyIYIyQVdw5XQXpX53s2wehp8N?=
 =?us-ascii?Q?H5drBb8Xep48whHwiYbvsNfd9vxQCZ6S/LQzCvrsvfHWtN+QaU/qk1MwvwWG?=
 =?us-ascii?Q?uDLZLuKDCpNouAcboryI1jI/pGaGn9eFI235pvOxJ3I1hTXPrY4l2s3grwKq?=
 =?us-ascii?Q?SfL7S8AEzQ4fx/s/gr9MgTfjimta/kLqOQVCzWGejWOKDaeVGYlwMvRWgisy?=
 =?us-ascii?Q?qGLgjSzBZCdLTPtigCJJOj/OJC7xm5jdRX9J6NLTReJEIqUhItPiGTqK5wYN?=
 =?us-ascii?Q?+kkNO4LeFgEpfv0atrg9qxP++0ivz5kXrkNmmPQgKUuw6oeQSNQnmbDO70YA?=
 =?us-ascii?Q?GR6QG40QhZkJ/wf4ij2an5aUTXAz4dmPQCpz/ueSaxIlOdt14U9Rf5x1n/hh?=
 =?us-ascii?Q?iZRqedbsQY0//M6dm2eZv+Fqph6+NIxX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DL9Eqsncys9Dard0buX+7asSz4IP47fPqCNaag2NxpwAzpAaadObsULt7Rh6?=
 =?us-ascii?Q?srYQzpAG3hEnnPB9nJiAny1ChkDB94QfBysxddCLBD4nG67RpZXh/1H35aRH?=
 =?us-ascii?Q?+FacQsFl0VilknxnVVN+g1yGy0GncaU+i6dtuBwKZbaJAymuCv2AD12sMes/?=
 =?us-ascii?Q?7izZRYMcK6jqn+cH/g0ArJqZ5ZJVXDhK9MJxOcMEUcy0NW/A9Xa25fAK5lle?=
 =?us-ascii?Q?659AYO7UYqRV1rFgq2/pBLeJO7UsQIPN+iLi5N16ZvQG2Z7ffkMWKDquaRsj?=
 =?us-ascii?Q?MfkcFnpBN0XrG8HSOGBDWs0ESIdpn74j8Y24KaZkkXhMZc3ld6AiUThUDzcG?=
 =?us-ascii?Q?e+Cw3vdB016SehqHFn4Q4jWsj0Aqt46mSS/hb5QCZnNkYuvRmIXeCgShemZk?=
 =?us-ascii?Q?ggUKX9BH2pc3K2wKkKB+Lx50MGuco75+CiOUk8BlONpHEFEql7joiDMGrkYC?=
 =?us-ascii?Q?9f3fUOtQuhqTLTeBS/36yAzKFeSyR/YLtfajbBgZa0mk0lwE0+Ly8KjS5Gbc?=
 =?us-ascii?Q?/ptL/xFopgfHvyxtheyejAidHTZskKjrrafiDva7nt9Qlk6CGOwRElbKOF9Z?=
 =?us-ascii?Q?ijJ4A5RySdHbp5M5VeckrqNb4zlFuYs/XPDxJOK3QVQPMlmRT0DDX23rMWWQ?=
 =?us-ascii?Q?ojFn4ckz/D5+PMm0S65w8akJWuSJMTXiCO5qLuirYhZnoaFoZ6O9yht2Z0mf?=
 =?us-ascii?Q?d1/cus4e1MNuq/pDBvRI2RXC09UYWbRI2G1VTX9uvo4WDYWwcuJauUSVFkZX?=
 =?us-ascii?Q?f9ntMeeBselsV5yHuMJUzTqE6Wk4WY2r6vbRR7FogiBM9SZf7jFnl7fIUWAo?=
 =?us-ascii?Q?/LpZwafekJYwMUQJz7MEr0Brei60JwL+QWsvMnwVS0FTFuZ7pU5a+YphGf9w?=
 =?us-ascii?Q?qgSMu2+9dpRGxJnl5pbSUI9VO9CNCwf7+O6rYwSxc0rWNW3v0NsQCYGaBIU1?=
 =?us-ascii?Q?YqKd77JAAwQDcXZT53IQmH3IQdCH4SpX2SHpKzKRwrFBPUa9UoFCd+dZM10w?=
 =?us-ascii?Q?ZUS2bSKnjo7lBGfz2znUTQ20n7Pu1pz1oluDIAOYwRnHRH5KLtsciDgrpY5R?=
 =?us-ascii?Q?RWShlWgTfCGGkb1NvQO10AqvqSE5m0Y6KDYdH57HnUcs/BbW+6vH+GZMnhaT?=
 =?us-ascii?Q?Lqa3JbxU9tQdD97Iqrv372KVyUzMCzttmJKSg3d8GUiVdeaWyu+wE/fbc/4e?=
 =?us-ascii?Q?bXxBiw2HMO93/e0MaqfjCR8Fz52k1VHTQQDG0cNiC5w//fNltf2xXN0522oD?=
 =?us-ascii?Q?EAqZrqtK4ApTIL3j7d8XGgHNpdE7G0T0Ab6NGn45t+DzRn9RbwVUFeMkTRw6?=
 =?us-ascii?Q?BM+8bKyQsoImPBHCXSqLmpQiewUW+ZedapLsIRzK57ATRJVRZQiJqZAD1nRK?=
 =?us-ascii?Q?u429anaI95tCT6w8yGXnlC64kdIUdfMSwIX2q+7TLBQpyo8+EPe51TQh31nl?=
 =?us-ascii?Q?K8wi+xR0LrU/ClEweh3WWW+a84W8GM5hFsOgtjGuY2k4GzVOARnsWSxKLkNK?=
 =?us-ascii?Q?2QmgME9ieR0jLXR93nF8Mo8EZcyr+FVlKxatygZjGB7j4zF4wUyAOsMU7lsU?=
 =?us-ascii?Q?e84Rqb140cMnhXHhN/vjDjuxQUeEybY6BxAp8SfzgI1dvmlugiPLfSsXcvrC?=
 =?us-ascii?Q?3JeEjrYzcqz7deqkewZ6zR0=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dac1870-45ae-444d-5f9e-08dd2b73e1f0
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2025 21:24:46.9923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lx4dEjkB3lSFK+pCKeudvqvrAcg7QGnHdV6DSmSlT5nzh87OexmHiKwAdkWTYdSazmA43RhPsB1vfQujbIjCOCoG20IBQXuSm00Q6zaENlzjbM7aAJIwPbb5w/sYOPtO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR01MB7909

On Tue, Dec 24, 2024 at 03:28:55PM +0000, Jonathan Cameron wrote:
> On Thu,  5 Dec 2024 13:18:48 -0800
> Zaid Alali <zaidal@os.amperecomputing.com> wrote:
> 
> > This patch fixes the kernel test robot warning reported here:
> > https://lore.kernel.org/all/202410241620.oApALow5-lkp@intel.com/
> > 
> > Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
> > ---
> >  drivers/acpi/apei/einj-core.c | 41 +++++++++++++++++++++--------------
> >  1 file changed, 25 insertions(+), 16 deletions(-)
> > 
> > diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
> > index 04731a5b01fa..74dfb3daba50 100644
> > --- a/drivers/acpi/apei/einj-core.c
> > +++ b/drivers/acpi/apei/einj-core.c
> > @@ -215,20 +215,22 @@ static void check_vendor_extension(u64 paddr,
> >  {
> >  	int	offset = v5param->vendor_extension;
> >  	struct	vendor_error_type_extension *v;
> > +	void __iomem *p;
> >  	u32	sbdf;
> >  
> >  	if (!offset)
> >  		return;
> > -	v = acpi_os_map_iomem(paddr + offset, sizeof(*v));
> > -	if (!v)
> > +	p = acpi_os_map_iomem(paddr + offset, sizeof(*v));
> > +	if (!p)
> >  		return;
> > +	v = __io_virt(p);
> 
> That's a nasty forced cast. Far as I can tell all this code
> should not be assuming it can just cast away the __iomem
> 
> I think it should be fixed by using readl() etc or
> memcpy_fromio()
> 
> Maybe it is safe to just ignore the marking for all current ACPI
> platforms, I'm not sure.  This isn't a high performance path so
> personally I'd just do it the generic way even if it is not
> strictly necessary.
> 
> Jonathan
> 
Hi Jonathan,

Thank you for taking the time to review the patches!
These iomem warnings were there before the new patches, since the code has to
access iomem location for read/write to communicate with firmware.

I agree with you on ignoring the marking for ACPI platforms. I can also change
the code to use memcpy_fromio() to create local copies of iomem locations, and
write them back later instead. However, it will add a little more
complexity to the code, because iomem mapping and subsequent reads/writes
happen in different functions.

please let me know if you have any more thoughts on this.

Thanks,
Zaid Alali



> 
> 
> >  	get_oem_vendor_struct(paddr, offset, v);
> >  	sbdf = v->pcie_sbdf;
> >  	sprintf(vendor_dev, "%x:%x:%x.%x vendor_id=%x device_id=%x rev_id=%x\n",
> >  		sbdf >> 24, (sbdf >> 16) & 0xff,
> >  		(sbdf >> 11) & 0x1f, (sbdf >> 8) & 0x7,
> >  		 v->vendor_id, v->device_id, v->rev_id);
> > -	acpi_os_unmap_iomem(v, sizeof(*v));
> > +	acpi_os_unmap_iomem(p, sizeof(*v));
> >  }
> >  
> >  static void *einj_get_parameter_address(void)
> > @@ -253,9 +255,11 @@ static void *einj_get_parameter_address(void)
> >  	}
> >  	if (pa_v5) {
> >  		struct set_error_type_with_address *v5param;
> > +		void __iomem *p;
> >  
> > -		v5param = acpi_os_map_iomem(pa_v5, sizeof(*v5param));
> > -		if (v5param) {
> > +		p = acpi_os_map_iomem(pa_v5, sizeof(*v5param));
> > +		if (p) {
> > +			v5param = __io_virt(p);
> >  			acpi5 = 1;
> >  			check_vendor_extension(pa_v5, v5param);
> >  			return v5param;
> > @@ -263,12 +267,14 @@ static void *einj_get_parameter_address(void)
> >  	}
> >  	if (param_extension && pa_v4) {
> >  		struct einj_parameter *v4param;
> > +		void __iomem *p;
> >  
> > -		v4param = acpi_os_map_iomem(pa_v4, sizeof(*v4param));
> > -		if (!v4param)
> > +		p = acpi_os_map_iomem(pa_v4, sizeof(*v4param));
> > +		if (!p)
> >  			return NULL;
> > +		v4param = __io_virt(p);
> >  		if (v4param->reserved1 || v4param->reserved2) {
> > -			acpi_os_unmap_iomem(v4param, sizeof(*v4param));
> > +			acpi_os_unmap_iomem(p, sizeof(*v4param));
> >  			return NULL;
> >  		}
> >  		return v4param;
> > @@ -325,6 +331,7 @@ static int __einj_error_trigger(u64 trigger_paddr, u32 type,
> >  	u32 table_size;
> >  	int rc = -EIO;
> >  	struct acpi_generic_address *trigger_param_region = NULL;
> > +	void __iomem *p;
> >  
> >  	r = request_mem_region(trigger_paddr, sizeof(*trigger_tab),
> >  			       "APEI EINJ Trigger Table");
> > @@ -335,11 +342,12 @@ static int __einj_error_trigger(u64 trigger_paddr, u32 type,
> >  			    sizeof(*trigger_tab) - 1);
> >  		goto out;
> >  	}
> > -	trigger_tab = ioremap_cache(trigger_paddr, sizeof(*trigger_tab));
> > -	if (!trigger_tab) {
> > +	p = ioremap_cache(trigger_paddr, sizeof(*trigger_tab));
> > +	if (!p) {
> >  		pr_err("Failed to map trigger table!\n");
> >  		goto out_rel_header;
> >  	}
> > +	trigger_tab = __io_virt(p);
> >  	rc = einj_check_trigger_header(trigger_tab);
> >  	if (rc) {
> >  		pr_warn(FW_BUG "Invalid trigger error action table.\n");
> > @@ -361,12 +369,13 @@ static int __einj_error_trigger(u64 trigger_paddr, u32 type,
> >  		       (unsigned long long)trigger_paddr + table_size - 1);
> >  		goto out_rel_header;
> >  	}
> > -	iounmap(trigger_tab);
> > -	trigger_tab = ioremap_cache(trigger_paddr, table_size);
> > -	if (!trigger_tab) {
> > +	iounmap(p);
> > +	p = ioremap_cache(trigger_paddr, table_size);
> > +	if (!p) {
> >  		pr_err("Failed to map trigger table!\n");
> >  		goto out_rel_entry;
> >  	}
> > +	trigger_tab = __io_virt(p);
> >  	trigger_entry = (struct acpi_whea_header *)
> >  		((char *)trigger_tab + sizeof(struct acpi_einj_trigger));
> >  	apei_resources_init(&trigger_resources);
> > @@ -424,8 +433,8 @@ static int __einj_error_trigger(u64 trigger_paddr, u32 type,
> >  out_rel_header:
> >  	release_mem_region(trigger_paddr, sizeof(*trigger_tab));
> >  out:
> > -	if (trigger_tab)
> > -		iounmap(trigger_tab);
> > +	if (p)
> > +		iounmap(p);
> >  
> >  	return rc;
> >  }
> > @@ -860,7 +869,7 @@ static void __exit einj_remove(struct platform_device *pdev)
> >  			sizeof(struct set_error_type_with_address) :
> >  			sizeof(struct einj_parameter);
> >  
> > -		acpi_os_unmap_iomem(einj_param, size);
> > +		acpi_os_unmap_iomem((void __iomem *)einj_param, size);
> >  		if (vendor_errors.size)
> >  			acpi_os_unmap_memory(vendor_errors.data, vendor_errors.size);
> >  	}
> 

