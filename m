Return-Path: <linux-acpi+bounces-13008-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57AFBA87E8D
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Apr 2025 13:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 872CC1896FB1
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Apr 2025 11:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34EB6290088;
	Mon, 14 Apr 2025 11:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="adC9/XQH"
X-Original-To: linux-acpi@vger.kernel.org
Received: from outbound.pv.icloud.com (p-west1-cluster1-host7-snip4-2.eps.apple.com [57.103.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DD027EC99
	for <linux-acpi@vger.kernel.org>; Mon, 14 Apr 2025 11:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744629047; cv=none; b=cxuiAzo5D+kmUEn82Zd9oLxSMTKt9myAXHQkpncHjQJVGqZF2FHGv9+xWwew8N95kXPvvJHo4B1J80RUAlZDn20IUP5BayBh5FgTs6jTy0O/WoT8J4MdJ0Zekme7qBzb0bOVSdbvKGzJV3PJ5g8IbwrNc9LABAF+a7MPhz/pwSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744629047; c=relaxed/simple;
	bh=PafN8z8zHH7ZH29aqmC1CQ1jw5BO3fvA+u2a60KyaHw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D/Emu6Kczh17iLlq37/m1LQ2C49vXpfTJtwwZ1tT8Q5Bh3ds4BpPiuYrvoLqpMyWM6xkm/SjnX/C5EMazfw+u+4gFsGqFyGobmV80Sic7QtNp9/PWuHCsNYjhoYDZp7kFlQz5PlKtin+Y28od2OYU3RzK/QYlvN2+Mzjkmv25Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=adC9/XQH; arc=none smtp.client-ip=57.103.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=MLy5tVDZ36BVgdmmtjXmu/rneKq26t7A9Py8c/K5oEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:x-icloud-hme;
	b=adC9/XQHC+DI9Vp03TpQFwbcRQ3tKnSCOUiRGm5/palIrjNErgXcm05ByxPH0roX9
	 GLS9W7BhW/b1FyCuMBNqndy3ZDYzJaAFi4rrmAdQ+FtU88lPRCFgcV4ijygSmon5rx
	 ZCzvCPTOZjPvirEWTBGDZ8GmCkEyLMLUhu3zDIX5wqCbfGO83XptzHio/iPhnCoYxC
	 ltlyY/qmu75Mk8umVjgRTHUa71KF6HSLiDLR0BbEQDkyLsIfWk1nPKYQnjAhYj68lu
	 QzivVPiUfW5ltT17hRnlI85hWSm+hbf4DFEwIQiGq8fQwUQmm1aUfxj5lFLKyQsYfb
	 Es2BndplLD2OA==
Received: from [192.168.1.26] (pv-asmtp-me-k8s.p00.prod.me.com [17.56.9.36])
	by outbound.pv.icloud.com (Postfix) with ESMTPSA id 8BA7D1800231;
	Mon, 14 Apr 2025 11:10:38 +0000 (UTC)
Message-ID: <3ae62405-6ebf-4da4-a946-deb74cd4f93e@icloud.com>
Date: Mon, 14 Apr 2025 19:10:33 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] software node: Add comment for the first ERR_CAST()
 in fwnode_create_software_node()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Daniel Scally <djrscally@gmail.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 Zijun Hu <quic_zijuhu@quicinc.com>
References: <20250410-fix_swnode-v1-0-081c95cf7cf9@quicinc.com>
 <20250410-fix_swnode-v1-1-081c95cf7cf9@quicinc.com>
 <Z_zAo3PTEWH9nkTt@smile.fi.intel.com>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <Z_zAo3PTEWH9nkTt@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: MdS5mcPft3y91odE22QgGzxDPsqFDVFy
X-Proofpoint-ORIG-GUID: MdS5mcPft3y91odE22QgGzxDPsqFDVFy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-14_03,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 clxscore=1015 bulkscore=0 spamscore=0 mlxlogscore=686
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2504140081

On 2025/4/14 16:00, Andy Shevchenko wrote:
>> From: Zijun Hu <quic_zijuhu@quicinc.com>
>>
>> ERR_CAST() is normally used to cast an error-valued pointer type to
>> another different type, But the first ERR_CAST() is to cast away the
>> const in fwnode_create_software_node().
>>
>> Add comment for this unusual ERR_CAST() usage.
> ...
> 
>> +	/* Only cast away the const by ERR_CAST() */
>>  	if (IS_ERR(parent))
>>  		return ERR_CAST(parent);
> TBH, I don't see the value of this comment. And looking into the code, I would

thank you Andy for comments.
will drop this patch in v2.

> rather drop this part. The current users do not rely on the any specific code
> to be returned and also they check parent to be valid beforehand.
> 
> But let's hear others first.


