Return-Path: <linux-acpi+bounces-11013-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48802A30BA1
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 13:20:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A25A7A3D20
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 12:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DBB31FC7F5;
	Tue, 11 Feb 2025 12:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="YvF4nr/L"
X-Original-To: linux-acpi@vger.kernel.org
Received: from pv50p00im-zteg10021301.me.com (pv50p00im-zteg10021301.me.com [17.58.6.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C421FA14B
	for <linux-acpi@vger.kernel.org>; Tue, 11 Feb 2025 12:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739276415; cv=none; b=EX3IG6t0BrwC6Zxh64FckztscaluCvuSYMgwV+Mt7ScGLta8/oee5j2twXUYF/yNvHLSWyNffShpcBzSVqJzEvy7S+6+o9JyW/yauKdN0YcL+/7uQOjIFjhub3mHodG6GxbWQEXHeIZuusE71A3kASbBW9r+Gm3oYcWcebzfBbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739276415; c=relaxed/simple;
	bh=vz1415JVI0hemZp9y7+iy+2ejTRhGeaj84A6sqY5U20=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FUAuRsmd+RazzS9pZsZUvt9UQMTVjPUimWBwN0jxjcqfkKPOajEuxhq9h0NjHdbDWVYGLVdflKJsMDQ/X5jmnVVi8vpZZoly3cK7yVFp7WFT1mJMYoNWkTFXwTDOhfhwtO+xQ9NFd8Z1VLpo+jboSvEoBHwxadlznJYQ3WsELIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=YvF4nr/L; arc=none smtp.client-ip=17.58.6.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=7H+QqN9lxO4qWHe77GaH0JBEidIHMZg9rUvVjiFrMa0=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:x-icloud-hme;
	b=YvF4nr/LWpwQKzdLjm+aokLtV8WKIeBZMrqujngPBnhtiqhszPFoblfh5i30ot64h
	 wLlNwMj1UWxP/f2dIafMlLclbt644M9EnK5Pgk6Hao0c5TdQGPu+cmfeaRR2yOIv2O
	 VlZCgT9R9RPrBdg9CKWumTPfw+K/cpK+nLrd/8wQhBlHlzusvQHE3bWks7kKGD4xyH
	 03rB+LTRGsQFPKJt2owiNCiUgVxUlj3UM3VRc+63bydz53ILm0M/EO3NAK9hgLfuB0
	 EsSmhlpY2/tiWGgm/GerypQadL/8JCf5043TV42yYCpJ1iZm6JHml8cGfsdrrCb+sa
	 7a7NFiE/SwZ0w==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-zteg10021301.me.com (Postfix) with ESMTPSA id 4CD9450023D;
	Tue, 11 Feb 2025 12:20:07 +0000 (UTC)
Message-ID: <73eb84f3-8b9d-41f4-9b59-d059111a3d03@icloud.com>
Date: Tue, 11 Feb 2025 20:20:03 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] of: property: Increase NR_FWNODE_REFERENCE_ARGS
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, "Rob Herring (Arm)"
 <robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
 Len Brown <lenb@kernel.org>, Daniel Scally <djrscally@gmail.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, linux-acpi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Zijun Hu <quic_zijuhu@quicinc.com>
References: <20250210-fix_arg_count-v3-1-a084a5013008@quicinc.com>
 <Z6oclML_DC1Vnf6z@smile.fi.intel.com>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <Z6oclML_DC1Vnf6z@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: rdRsnCg6w0UNwgaf2iFZO85ujgoJvDvj
X-Proofpoint-ORIG-GUID: rdRsnCg6w0UNwgaf2iFZO85ujgoJvDvj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-11_05,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 clxscore=1015 suspectscore=0
 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2502110080

On 2025/2/10 23:34, Andy Shevchenko wrote:
>> It may cause firmware node reference's argument count out of range if
>> directly assign DT node reference's argument count to firmware's.
>>
>> drivers/of/property.c:of_fwnode_get_reference_args() is doing the direct
>> assignment, so may cause firmware's argument count @args->nargs got out
>> of range, namely, in [9, 16].
>>
>> Fix by increasing NR_FWNODE_REFERENCE_ARGS to 16 to meet DT requirement.
> ...
> 
>> -#define NR_FWNODE_REFERENCE_ARGS	8
>> +#define NR_FWNODE_REFERENCE_ARGS	16
> Thinking of the case, perhaps you also want
> 
> static_assert(NR_FWNODE_REFERENCE_ARGS == MAX_PHANDLE_ARGS);
> 
> to be put somewhere, but I don't think we can do it in this header file.

thank you Andy for code review.

yes. it seems there are good location to place the static_assert().

is it okay to associate two macros by
#define MAX_PHANDLE_ARGS NR_FWNODE_REFERENCE_ARGS
OR
replace all MAX_PHANDLE_ARGS instances with NR_FWNODE_REFERENCE_ARGS
?

