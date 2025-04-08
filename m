Return-Path: <linux-acpi+bounces-12846-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F8AFA80052
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Apr 2025 13:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42FDB3BD438
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Apr 2025 11:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D908D267F65;
	Tue,  8 Apr 2025 11:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="fYoTSXA2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from pv50p00im-ztbu10011701.me.com (pv50p00im-ztbu10011701.me.com [17.58.6.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7521D2192F2
	for <linux-acpi@vger.kernel.org>; Tue,  8 Apr 2025 11:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744111397; cv=none; b=hUBoVyHWjqlFWjuiHEt3t1FUUz6HB4O1tlU/fla9MVcYvwMlRHcuvX7AW+Kmy9aBlGg85ZuOI2GWXkCqw0J7Xori4AO3JCUJ4qz/BrZXBaymjdZTTa8nixCkq9vCJUWIxeT3KhFkZtNWIn5IdAjBZW0J+5IcK+TVVd4AB405vgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744111397; c=relaxed/simple;
	bh=ozIZ9X6cm1p2EJP1ur2x2xqVdPIqBJdiXWENd7PDQ60=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aN0RKf89kM8t5ethzqVcreeMXYHNBP2qeXuCCz4JUg3PTKDTIqiTCa82U8XwUCLYSCJvLlgwycR3YmfMiesJw3Mk/DUQ0iPHeYJXdDMqYFVBtXh9iahAGC05atgoL2StF17JjPCpvauyLlgylhgBCsmmYIo8ui3CeT/lYc+TgNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=fYoTSXA2; arc=none smtp.client-ip=17.58.6.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=qLC+AjXbCpLuLsLmei8R38sdvc8cBnY6Kum200DDnZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:x-icloud-hme;
	b=fYoTSXA2wiARvZWYposFpz3cLPyY6NJ2v2RTcpTdhrj+ntYB4NwVTIl6hP9hHe3P5
	 41Out3djOsANwmR3iY2KMk+Ha0TSWUyjJnEJqBMOZPHYRmiN5j9ONyLY1sXMmFX5Z7
	 jmYi9jTc3+C9SSjYv4DnuikltwmnMeqj30qgoRWRV0g6fxwDwKPU4zzzQ2+9bnZi+K
	 KENTQtJAnCJjU/KiZBwGuvupPbdIOZkwGS/q5kp/n4wOap4pIEjr9DVOP4kZSkUCmT
	 900uWfSqE9NslpaWU+gbGkPznZcNYXsYyyM5Ss6X6+7d89KKtOGKuLdtimimSgfLph
	 k6xxns0fgWryQ==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztbu10011701.me.com (Postfix) with ESMTPSA id 964AA740328;
	Tue,  8 Apr 2025 11:23:10 +0000 (UTC)
Message-ID: <43e66024-6d51-44ce-b466-56c06b29c66a@icloud.com>
Date: Tue, 8 Apr 2025 19:23:06 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] device property: Add a note to the fwnode.h
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
References: <20250408095229.1298005-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <20250408095229.1298005-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: v7hq0q6rugjvqhheSEamUejNlt-XNCVk
X-Proofpoint-GUID: v7hq0q6rugjvqhheSEamUejNlt-XNCVk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_04,2025-04-08_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0 mlxscore=0 adultscore=0 clxscore=1015 phishscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.22.0-2503100000 definitions=main-2504080081

On 2025/4/8 17:48, Andy Shevchenko wrote:
> Add a note to the fwnode.h that the header should not be used
> directly in the leaf drivers, they all should use the higher
> level APIs and the respective headers.
> 
> The purpose of this note is to give guidance to driver writers
> to avoid repeating a common mistake.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> 
> v3: reworded the note, added problem statement into commit message (Rafael)
> v2: added "...into the driver" piece at the end to remove ambiguity
> 
>  include/linux/fwnode.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
> index 87b183595ba1..900ecd8f45a1 100644
> --- a/include/linux/fwnode.h
> +++ b/include/linux/fwnode.h
> @@ -2,6 +2,11 @@
>  /*
>   * fwnode.h - Firmware device node object handle type definition.
>   *
> + * This header file provides low-level data types and definitions for firmware
> + * and device property providers. The respective API header files supplied by
> + * them should contain all of the requisite data types and definitions for end
> + * users, so including it directly should not be necessary.
> + *
>   * Copyright (C) 2015, Intel Corporation
>   * Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>   */

Reviewed-by: Zijun Hu <quic_zijuhu@quicinc.com>

