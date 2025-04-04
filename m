Return-Path: <linux-acpi+bounces-12728-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43DDBA7B662
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Apr 2025 05:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3CAB189CFE4
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Apr 2025 03:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F34E1A3147;
	Fri,  4 Apr 2025 02:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="icb1fn/E"
X-Original-To: linux-acpi@vger.kernel.org
Received: from pv50p00im-zteg10021401.me.com (pv50p00im-zteg10021401.me.com [17.58.6.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24ACD19DFB4
	for <linux-acpi@vger.kernel.org>; Fri,  4 Apr 2025 02:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743735595; cv=none; b=bFk/JDTzZeC0qn0E9kru0xvjm5bXV1J3o1nnFJ5TuHFROD0cQiTHYfEHcrQjeQRbu6fmZTbJDom/BuPzIk4daTGp1OcMUUUcCYKr7MWKhW3VFiCb6m5uSS/2/ji6T8lz4EGMUYP6Xa9eWcnEYAzk/yWO7IPl990m5iaTeph3PoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743735595; c=relaxed/simple;
	bh=a59/dCArZpjmdu1CA2ns6K7frhrEdPJ4+b5B41x0SKk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UlIA7WAlw4ZXHGnfNPtmR5saSurP721NWJ7EJE5pdZPCvvNHfMFfbVvuqqHihAfU91pauJxQnN+93AQzvyjLTEd7b1PAQQp5TW3ipYGMyBA1UFy4COfzsxtrf6uQ2IwlG3jzhARFE36L8e3hyvY9QJZA7+Y22Qf67zTSLAuwmqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=icb1fn/E; arc=none smtp.client-ip=17.58.6.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=fG3CGqe+hvK5S3evRDdon69vZKGIehTLbtFqN3Fym2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:x-icloud-hme;
	b=icb1fn/E/NlnyCRVqy/8M6PrlMWO6CDU4dX2glMzFngDDg711ZTkm8yHSclRy4MLI
	 L1ik1qVKxj2mCQwCACsTWjShOr3e0RyxuAel4INOws1+b5ATIj98vfmN3TWcDkIpws
	 lcUY+C1ZNkFfaOgszw8/yPvGM0XP9zcs3R2rlrDIn93WzW8Jrep/Jnbk102H1kq83d
	 MEBTReNAwVjSY3n91Nh9HG9VQP6j8VJiBBvle1Y+4tU3xkB2cTC3QUxPda51piDn1u
	 cCbhJbCFDp3bhYdlXsKS9SErKeVbO9o3lxNdUtnA2+QbYAdqA/OujAHKuxsHKG1EUC
	 iHa+kBrOv+caQ==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-zteg10021401.me.com (Postfix) with ESMTPSA id D3BB88E0091;
	Fri,  4 Apr 2025 02:59:45 +0000 (UTC)
Message-ID: <f6dd3667-8528-4597-963f-75e78d7be733@icloud.com>
Date: Fri, 4 Apr 2025 10:59:41 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] device property: Add a note to the fwnode.h
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Zijun Hu <quic_zijuhu@quicinc.com>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Daniel Scally <djrscally@gmail.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
References: <20250331163540.280606-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <20250331163540.280606-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 1U1YPAE7jr6a27fniVEr3Z9tVBQ1j0QS
X-Proofpoint-ORIG-GUID: 1U1YPAE7jr6a27fniVEr3Z9tVBQ1j0QS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-04_01,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 mlxscore=0 clxscore=1011
 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2308100000 definitions=main-2504040020

On 2025/4/1 00:35, Andy Shevchenko wrote:
> Add a note to the fwnode.h that the header should not be used
> directly in the leaf drivers, they all should use the higher
> level APIs and the respective headers.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> 
> v2: added "...into the driver" piece at the end to remove ambiguity
> 
>  include/linux/fwnode.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
> index 6fa0a268d538..4c4d3f93534c 100644
> --- a/include/linux/fwnode.h
> +++ b/include/linux/fwnode.h
> @@ -2,6 +2,12 @@
>  /*
>   * fwnode.h - Firmware device node object handle type definition.
>   *
> + * Note, this header is not meant to be used by the leaf drivers.
> + * It provides the low level data types and definitions for the firmware

Ack

> + * and device property providers. The respective API headers should
> + * guarantee all the required data types and definitions without including
> + * this header directly into the driver.

device property(include/linux/property.h)
	       ^
	       |
firmware node(include/linux/fwnode.h)
   ^           ^         ^        ^
   |           |         |        |
   DT         ACPI     SWNODE    ...


For various firmware implementations(DT|ACPI|SWNODE...), i feel we may
allow them include fwnode.h by their header or source files.

> + *
>   * Copyright (C) 2015, Intel Corporation
>   * Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>   */


