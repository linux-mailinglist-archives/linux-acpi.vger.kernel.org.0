Return-Path: <linux-acpi+bounces-7914-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8866961DD4
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Aug 2024 07:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D58281C20BC6
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Aug 2024 05:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0497814A0B9;
	Wed, 28 Aug 2024 05:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SKs1j+Ul"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3899C12E1D9;
	Wed, 28 Aug 2024 05:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724821742; cv=fail; b=XiIHP07RT5fnuBW8rcMK7hFNlCTsCnXbmL+sdMTYEYRww4PWgqWQT5H7L4R7GJ1c72K5rkSj3u3l2TuEvyAP+WNUyfG11hIGvFfj9qeGH18v5TVMlLk8WqZ6b15u9lF+lqCGYY3LfBiHA8KyabPHtJthdXL9S2BP0tBx+jEpTQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724821742; c=relaxed/simple;
	bh=S+5NsG7ivCOt5FYX6dkAq5zBciZbEHQRuGvvTY6OcHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VMlBUPij1/ynLtA7XDXphIrqjiG/Lu5Etzq6CIRtjFPyqgySuAaAXm2ighsl+5UEk+hC36d/8p92pFKVnRBNf8WkEi3inwT5WScskkXo/FDBa/J1yJaH9M3gV3uA137dFfABc5Xgrjbo9GTaSMcuJqFPcQZ5SBX8FeFFYrsveZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SKs1j+Ul; arc=fail smtp.client-ip=40.107.244.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QUGL3JMlhmVggldIX6i6CMw/E5rM5fyWDEvF+IUEU5bc5cHHkOUAwJEA79JfAy8YwJILV2giu8/VaImoNbR3MtOMOG1kEMefHr1tzkLL8MIgLndYksn7xnmoS8NgIicYMbGWDTDZCD7uQ/W3HT3G7P1uXKAwO/x0ZW2umbyyigpk+HGeMqRz2D9XnBDOtsxWzBM9AI+WACbMDzBBPl9zw5lWoId7SOkvelUd+0NrDNoGsoLvzBAlIRfI5u3tV0lX2pFDprXvbM/d5F4n49FeKpJXhdaCrV79+ErDAZ4OfUNnVDkpzTzKbMbhKbTvVkuZdjUONycCmP7GgBZcJiFCtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GrH0E8xZaJMihGIb1DUzpZcbOcUMxum/jEkOkIWmkjc=;
 b=zQwSm2OpNZLzbZWO8fDCJlH7OeP0ND5bD4fY6DbcH3FvqEWHub8PMUe0GUXvs/ltpbRaSJsiHfM8TTNe2A2h7BbDuquSRpPUq4YVoEtcrdE+u9CXydbPldfZW08IL8EUhrW4C3S5PsOhiv4XTC024+zRykN0/DL1AGMLIU0u6JlGQ0ZGsL6g/iV6wCBhdk5hasObN66I4dOSsLQgauW826B5fC447Z77qCGD153T4N9dGGdM5+wsRPGSihiTJ460L5i249WjYhHz1T9dBqyEaaOcmKPafLCDCD0REyo7+qMaXcLvMFIc1ccTtbzVWhZ+7O2WaroTtFLU5yNKR5oY0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GrH0E8xZaJMihGIb1DUzpZcbOcUMxum/jEkOkIWmkjc=;
 b=SKs1j+Ul6HtKQMF/3wvlhzkfl3uqIeLeUvFwCrkabfiw8LiGa59tJiwqukr1i5mEio+lRjnGezJsxXztue53nLwC2hL4iULapV2cuUAMdXqgGX2gWNVL7Ksm2fVBq43ELBSIQrEiX3IMOni3oiFCIMjmLCWpvtMP53MoKY58V6s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 IA0PR12MB8983.namprd12.prod.outlook.com (2603:10b6:208:490::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Wed, 28 Aug
 2024 05:08:59 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%4]) with mapi id 15.20.7897.027; Wed, 28 Aug 2024
 05:08:58 +0000
Date: Wed, 28 Aug 2024 10:38:45 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Mario Limonciello <superm1@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Perry Yuan <perry.yuan@amd.com>,
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:ACPI" <linux-acpi@vger.kernel.org>,
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
	changwoo@igalia.com, David Vernet <void@manifault.com>,
	Tejun Heo <tj@kernel.org>, righi.andrea@gmail.com
Subject: Re: [PATCH 8/8] cpufreq: amd-pstate: Drop some uses of
 cpudata->hw_prefcore
Message-ID: <Zs6w3RktAb6fJrJ+@BLRRASHENOY1.amd.com>
References: <20240826211358.2694603-1-superm1@kernel.org>
 <20240826211358.2694603-9-superm1@kernel.org>
 <Zs4G084+7MmzdYjU@BLRRASHENOY1.amd.com>
 <61b96549-2969-4b64-a40d-f91f614ec3ab@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61b96549-2969-4b64-a40d-f91f614ec3ab@amd.com>
X-ClientProxiedBy: BM1PR01CA0162.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::32) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|IA0PR12MB8983:EE_
X-MS-Office365-Filtering-Correlation-Id: c7472879-1542-4567-4c32-08dcc71f85da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ks5PXyF7+BDjvGCkkqENLr6OFCyEgBP6igxkRJ+Yii1i0SOkrvRnvIcYcG0l?=
 =?us-ascii?Q?1/WCDuFz64wlIgwlnCCJ7xVRTRPgAnn7kbp5Dc6LjhZl3XRJ0Og/9sO4fHLQ?=
 =?us-ascii?Q?ROuwcLGCGv3MVP8ix+S6LAq79ApDyUcpmA6aGGQpaX1uWn3DZn4Rah+OZJPi?=
 =?us-ascii?Q?XRXxlOLrLey0FqpDARbZPIncs+Az2CgY/BGbqOBynfPWW3T3EYCiwmSkeR1/?=
 =?us-ascii?Q?GfW/AIFhQBzwNdAErXgTHpRi6vxbPNzjlbUqZMQhfQBI6fhoEbkHwIZ4lF4I?=
 =?us-ascii?Q?lm4uPz3NwfrVNV0CexEqbZJMjGqT6vfcu/aNJU2NSJ5fPUIyi3TFysBvtvHa?=
 =?us-ascii?Q?xewG1Qyc7ZL3Kn+6Ya1Q9vSZ4az1uoPo5HSFgV789yVb5A/q0ttNqKrqiYz5?=
 =?us-ascii?Q?ZZQ2/UFiGnRu3dItdLcc0tLdyKJ0/XU1AWrsq+HMjxSxCdHsj2gIcLFcGij5?=
 =?us-ascii?Q?kpNxhcAilsHITEaoWQ5i/8EQI5RzRtDUSMZF+vgwtc9TOBPGhXBTeqHY+aUk?=
 =?us-ascii?Q?fLCueAFWYwbpsxwUFTCxcB315zmuys1BbVwu+h0R4aVNKFRKsSv0AfQQGMyp?=
 =?us-ascii?Q?hl7IVTv+yXpdtCCGGJgV1iw/fh5LAO0mFRU74RdFNHySghyplKHJHmBY5Om/?=
 =?us-ascii?Q?wEJi4OzpkbWMjuqns6X/u+sLqn5x1LeQ6150yogHlhA/qmfaZMOuUTNkGvey?=
 =?us-ascii?Q?Bd5G80VmH3yziIrGNjlibtvWAdrNMGoZsGLFUcdqOxy4a0myYV5qzY+H58xL?=
 =?us-ascii?Q?DsWqrn65mgYo7mFOyTxCcz0NV8Eg189gwnMX/luulcMehGAlwWE59JXsCt8k?=
 =?us-ascii?Q?7w0dl/onGxIXXgWsdAo08D6fimpu6TyOvpBXzA2j5vMcNiSa8XfJNwkOJGk6?=
 =?us-ascii?Q?L2yWjfOsEha5STbh63wDzmz/8K7Yoz7SbzaOsYuVnhnoSTodvbf29FtSDToe?=
 =?us-ascii?Q?GEFsnWAmhnjwGCt91iJPUbHSv3FBVdP6d2uodBw9KIFh4hSz66gI81tf3PQu?=
 =?us-ascii?Q?Yodn4iOx9aJPC6FaZKfslScucHOdVeS8v49Wr00vl1vW/QLUcmdLxiNuG0Nb?=
 =?us-ascii?Q?4QSDeVriYPK3+pKQy65QamZYoRMLJ2bZ83T3g4SGetKklTofgZmwd0OPazK8?=
 =?us-ascii?Q?cEqZQZNa0byDRwHj6ClPXoye3vDeDe1mEvjHNjQwTuktNVSaYccxNqXhkk2y?=
 =?us-ascii?Q?18AKJhxy9ADjXv2rNpsCZUD56GV71pJxBadLHfMUivV5gii+5swZeh3vx3MZ?=
 =?us-ascii?Q?oeQkbTIjEqTUM53wT+uvAsa3dy7BKCPBjBwQH8XeZCls7/wVTO7sTaDGcFv8?=
 =?us-ascii?Q?vtsqeYWNfzIlQPsBLv/673AHRYs9xhu9MsBPqzyDIvvk3w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?A22Izd18BYaz/oN76DNwxsLflRV88+GH9SpjC2sWCvjIt4xdmXzvWFnjgnqR?=
 =?us-ascii?Q?E8u5z8yBbKDdEImHqiYkUlJfDhgUbOMqO22E+7pmdAwM3TBhHRj5hX9mVbhq?=
 =?us-ascii?Q?ZWAjFooqlneOtq+FYEgbb7wcK1JbFEZ48ycKF/7fcM+9DGWmuIuyuqC8kFlC?=
 =?us-ascii?Q?Fvpj1EmSyLkem8kESKPHLBTQyhbpvCrVWSEPDW8cC7hU5dMdnW6pbOXoTbbm?=
 =?us-ascii?Q?UOcp/NzukVtooiT8Nx08UlwimrJUHGKpb2HJX+4aPwDyBEh7f7Sj4tulsq1j?=
 =?us-ascii?Q?kVQPlfMofaWVsiH0DFkcLTZuWpRGiHJPjRWmupLaRkXbqQSqP858vpI9yvjy?=
 =?us-ascii?Q?mG+Sokv2sDdo4NhBBhMzA2l6YKtEkcGrVxMYwruL8BoLv6dwuEF1Ll3q0785?=
 =?us-ascii?Q?JCUc5RSIhK9Jg1Zkuz82eF/kvBu+7khkPc1m/sZ8+UI+JP7imLbkXYZ5+g5Z?=
 =?us-ascii?Q?Jx7aHsuhdfl5BmvE9cKdhin0ZP1TYS8vNykvYD83pTTQtmseRKqOpl6mw4Zc?=
 =?us-ascii?Q?Yn01GBJBXbz/N/QtAQtxGBDBPSxW09VvWcvKg7DITYVUI4ROdA1FIOAzfCjt?=
 =?us-ascii?Q?Qh6RHX8hF3CEgUbgCL3+/cWlLnYoLcZ1x6aSjbUADBOKnvxe7DLmu9t01Nta?=
 =?us-ascii?Q?OP1BQn1OuVOg06JpJ+4YyMBKI3GuJydjjIP7G5nv50PU/viH6eG0xCIxYCv6?=
 =?us-ascii?Q?Ub2K3ShxpjdQfRsMvbJw80J+tcnqSrUr4u5NZoT38mEY0UEX1S2MkUq8TzMH?=
 =?us-ascii?Q?PexkvKgDzVK3j5x3IIgmDm/qWpE0BQaSGf/bv2Xd7Nzb8hJK5m+VvujFr8OR?=
 =?us-ascii?Q?a+zUbudOqB7e/dtXl9WhrnP4pVUY7SqGzf2xf8gf277wCXNWJgpQi2vb6lxT?=
 =?us-ascii?Q?kj9ETN+OslTtPnrc01A6ZjUafTY975L0CxKeL2wCGmB+9EZVz2ybzHYnPN+S?=
 =?us-ascii?Q?XUvQnKlQbuoZVw/UNqcomLO8ytwtpBdngHHEvmBZhUQKSv//7tr4el4kMpZV?=
 =?us-ascii?Q?/v//n9o3LEes0XkbPsti5TspQrmhzJcGXo87kHpooOFsYWO54nBgcf/IYTZc?=
 =?us-ascii?Q?DniZPKRikTuFl9tEgVb9SWgq4+NI/XXy2kRIZf4nx1Z2T1R3vNtSSZ4GiB5p?=
 =?us-ascii?Q?ViGYCiwIQ1fT3TE9P/ka+UlpXXiJ0EeRooUNTUjdZKQcWfqCVDsCR3cXOxLI?=
 =?us-ascii?Q?ciOwG1Y9GqChkMQDfwEss0ORpkhTbBqngRK+Xaq7aCm8d8kjZYPsCSbD8OTe?=
 =?us-ascii?Q?L4avlRgeHH2cjC/qAHZviTUiI9qfe++6+cF8CsxfDn1mCfXdESVr4sA0gOoq?=
 =?us-ascii?Q?VTAHGxAtp/LOZCbrt/7phaMcfjh5Vxmi5IHzo9fYwOlJT36JgI8rh1XGGbkD?=
 =?us-ascii?Q?xtGmvZEBMC5mqMysKHqhUV3R2DhOYtY5O0/6H4RcgfLdlq6qTT89lsYlIWNZ?=
 =?us-ascii?Q?1hojXuaP8xl8O10wNwZ+XWFirN0QdQ/D2hKPbfIbM/oTSPLL8hQk++EkJbOn?=
 =?us-ascii?Q?sFjtHKobMwX/HkV8/WRoAozaArAkzmTp8L00O5Zw4z9JuwDD2Tzim3xtv7gT?=
 =?us-ascii?Q?Q6SnRSI4TC0nqC7aPVQpbi3KVry3HI/OG24jxhLd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7472879-1542-4567-4c32-08dcc71f85da
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 05:08:58.6679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ChYqQ2nczpoRDfSpKWCvLx658+u4Vajm9eDQqHbmroOPzUZ/40jX+Eq5WcYAgyUGM3frAnefqYdCKCPYNeUuOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8983

On Tue, Aug 27, 2024 at 02:16:51PM -0500, Mario Limonciello wrote:
> On 8/27/2024 12:03, Gautham R. Shenoy wrote:
> > On Mon, Aug 26, 2024 at 04:13:58PM -0500, Mario Limonciello wrote:
> > > From: Mario Limonciello <mario.limonciello@amd.com>
> > > 
> > > As the global variable is cleared when preferred cores is not present
> > > the local variable use isn't needed in many functions.
> > > Drop it where possible.  No intended functional changes.
> > > 
> > > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > > ---
> > >   drivers/cpufreq/amd-pstate.c | 7 +------
> > >   1 file changed, 1 insertion(+), 6 deletions(-)
> > > 
> > > diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> > > index ed05d7a0add10..257e28e549bd1 100644
> > > --- a/drivers/cpufreq/amd-pstate.c
> > > +++ b/drivers/cpufreq/amd-pstate.c
> > > @@ -1112,12 +1112,7 @@ static ssize_t show_amd_pstate_prefcore_ranking(struct cpufreq_policy *policy,
> > >   static ssize_t show_amd_pstate_hw_prefcore(struct cpufreq_policy *policy,
> > >   					   char *buf)
> > >   {
> > > -	bool hw_prefcore;
> > > -	struct amd_cpudata *cpudata = policy->driver_data;
> > > -
> > > -	hw_prefcore = READ_ONCE(cpudata->hw_prefcore);
> > > -
> > > -	return sysfs_emit(buf, "%s\n", str_enabled_disabled(hw_prefcore));
> > > +	return sysfs_emit(buf, "%s\n", str_enabled_disabled(amd_pstate_prefcore));
> > 
> > 
> > If the user boots with "amd_prefcore=disable" on a system that
> > supports preferred-core, pror to this patchset, cpudata->hw_prefcore
> > would be true and thus, amd_pstate_hw_prefcore would show "enabled".
> > 
> 
> Yes; you're right about the previous behavior.
> 
> > With this patchset, it would show "disabled". Or am I missing something?
> 
> This appears to be another case we don't have documentation for the sysfs
> file `amd_pstate_hw_prefcore`.

:(

> 
> I had thought this was a malfunction in the behavior that it reflected the
> current status, not the hardware /capability/.
> 
> Which one makes more sense for userspace?  In my mind the most likely
> consumer of this information would be something a sched_ext based userspace
> scheduler.  They would need to know whether the scheduler was using
> preferred cores; not whether the hardware supported it.

The commandline parameter currently impacts only the fair sched-class
tasks since the preference information gets used only during
load-balancing.

IMO, the same should continue with sched-ext, i.e. if the user has
explicitly disabled prefcore support via commandline, the no sched-ext
scheduler should use the preference information to make task placement
decisions. However, I would like to see what the sched-ext folks have
to say. Adding some of them to the Cc list.

> 
> Whichever direction we agree to go; I'll add documentation for v2.

Yes please.

--
Thanks and Regards
gautham.

