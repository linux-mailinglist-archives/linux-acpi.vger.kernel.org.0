Return-Path: <linux-acpi+bounces-10685-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B8FA12519
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jan 2025 14:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1337B3A9E6C
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jan 2025 13:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2BD24A7FF;
	Wed, 15 Jan 2025 13:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="oRunAxFW"
X-Original-To: linux-acpi@vger.kernel.org
Received: from pv50p00im-zteg10021301.me.com (pv50p00im-zteg10021301.me.com [17.58.6.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCA524A7F9
	for <linux-acpi@vger.kernel.org>; Wed, 15 Jan 2025 13:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736948592; cv=none; b=JEokQyO/TgvkBMYjyy7feQ8iaAWAm9zyzzyRiIfAEWxhRETC1GsV0tPHf8cQBmInHShISJTfhHxazieM93jgE76guRHhw7GgUl7WOariOe2sk+FB5kmblsfwtghkp1J/YTSkWI0tjbZy7T165XQgCLYvkxaQkjHP537X19JI69g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736948592; c=relaxed/simple;
	bh=9bGsaCBn1UoeZkbY6qUHLvhH3L/aXhR8venmgMct7+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pC0eE0TziQjn3yGcDkqMlFFzHxkoRAo+Cu0u6/HIUjNyyHlpE5HVt0+7nb6HtRrmuZ/CFWy3iDx2FM6QP9YlgibraeCE73V26MCPqf4MqMiWj6L44vg8n4bwsJIIylqU3x792t+T5k17sCvXZdXLu7aLaa93/GI/C1fLUbBrjSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=oRunAxFW; arc=none smtp.client-ip=17.58.6.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1736948591;
	bh=9bGsaCBn1UoeZkbY6qUHLvhH3L/aXhR8venmgMct7+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:
	 x-icloud-hme;
	b=oRunAxFWu7FwJAC70TnDhaj2vR/++Y0/OpX1AZYncDBQhwDONcLq9FK9h8Hhdhgja
	 rTp/bE+ouzw5/DPHrvVuConobik8L/xBH8wjp5FvI71eOkP5159e4OPTm5WfSCTBA7
	 ftY0W9Z0PzCoNq1oTkssM05lxiA8uZg/R9VE84ALngtalBHB9gVsH98RICn468JeHL
	 U4PNmIiO91+PTldvriAZSzqf/h1UAiiCHRNWStg3y21UzLAQPKSlrIcOSI6MjDcBsd
	 IMZJI5Jn+0AxPT9EmjJ9TaLRF/MZgxQwEC81ZdiKUDuwgCBzfUcEwb15sf97Y0PGXL
	 Y0G4WO3Xir2FA==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-zteg10021301.me.com (Postfix) with ESMTPSA id 547905000ED;
	Wed, 15 Jan 2025 13:43:04 +0000 (UTC)
Message-ID: <a4e1ddf3-5a7e-48e4-864e-4517a7939c19@icloud.com>
Date: Wed, 15 Jan 2025 21:43:00 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2] of: property: Fix potential firmware node
 reference's argument count got out of range
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, "Rob Herring (Arm)"
 <robh@kernel.org>, Len Brown <lenb@kernel.org>,
 Daniel Scally <djrscally@gmail.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
References: <20250114-fix_arg_count-v2-1-efa35ee6572b@quicinc.com>
 <Z4aYZtR3WcbpCRui@smile.fi.intel.com>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <Z4aYZtR3WcbpCRui@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: H3R1cWWeNSbFo9E1j3GkPfSyaQcZQhP5
X-Proofpoint-ORIG-GUID: H3R1cWWeNSbFo9E1j3GkPfSyaQcZQhP5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-15_05,2025-01-15_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 clxscore=1015 bulkscore=0 adultscore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2501150104

On 2025/1/15 01:01, Andy Shevchenko wrote:
>> But of_fwnode_get_reference_args() directly assigns OF node
>> reference argument count @of_args.args_count to frimware
> firmware

Thank you Andy for comments.
will correct this error when send next formal revision (^^).



