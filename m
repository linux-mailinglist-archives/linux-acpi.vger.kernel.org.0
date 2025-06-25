Return-Path: <linux-acpi+bounces-14655-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DBA9AE9051
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 23:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EBD75A74E8
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 21:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974712571C8;
	Wed, 25 Jun 2025 21:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="WXvUjmL4"
X-Original-To: linux-acpi@vger.kernel.org
Received: from omta034.useast.a.cloudfilter.net (omta034.useast.a.cloudfilter.net [44.202.169.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EE725A2B1
	for <linux-acpi@vger.kernel.org>; Wed, 25 Jun 2025 21:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750887841; cv=none; b=G7MF81nhGQAqAGYu/BbYJthwW0LCJEbqcw7KbKK9y8weNNTYGwOQV2bic3kk9EHwKgSLYfvh6/seFsziZ//W2fM3V38cgnQbBRpm/DQoYHgvs8CHwk3B5RCumr8o6qKG/Ot+Ste6RzjAwrxZi1UQg+b/saDo8zUtqbAUNpohynI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750887841; c=relaxed/simple;
	bh=5lynVMriVClgMthsFZJ0Tvkpa1tGB9Lp6lL6aLGaCBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HO/fnWeqCW4652FrHHolRUZFWRGMAxAyvzXEL5mgtHXn4hFgNKfG1hVMYRcy4l1GHRXbbqNqA2N37VqykzI4akbRAhpivRhgIxLoQuVsZYc+LEe1GUPAS2f/6qB9TMhmIyjQUYiJqR4QHEogfNwY3FSAzkjXUY7Umb/4XpEAPSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=WXvUjmL4; arc=none smtp.client-ip=44.202.169.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5007a.ext.cloudfilter.net ([10.0.29.141])
	by cmsmtp with ESMTPS
	id USy4u7OoVXshwUXuLum9ee; Wed, 25 Jun 2025 21:43:53 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id UXuKuuHXlWhoDUXuLuDq7k; Wed, 25 Jun 2025 21:43:53 +0000
X-Authority-Analysis: v=2.4 cv=dbuG32Xe c=1 sm=1 tr=0 ts=685c6d99
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=y7jUFFJD1EYPe7d4fIfORw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=7T7KSl7uo7wA:10 a=QyXUC8HyAAAA:8
 a=h90DJapn4poTkUJIt3kA:9 a=QEXdDO2ut3YA:10 a=xYX6OU9JNrHFPr8prv8u:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=WSgqlLPFusC6Fal/vnl5EKpDH7EySq/W8ghCEckfU5w=; b=WXvUjmL4YQUvHcCnKTe5kb8SCL
	rnsv9zd6wvXpCP6BdUJEdEbS31FOYKxFzF5vK8xh1+91vJAqPlhKhBaWKsraEtwzk01P9PrbHxwcq
	I/v7ZOHYGKSTvVY/M84F+sJ4bP7RfEjL4yLqdGRy+lQeah6WgGWd1L7sQ9J3E43eBzflxqbqqvT7k
	tiAPJXW+zpRgDpS3hwJgcwJjIWx8UYfPrl/b+sEBSLpn7qDUpZNXng7jeq2w5mmOxnemOTgLyJv4x
	zMvUMqT8j0WOX59MfgQq4dAKM5geL3mQrqWmRTk+LecokoXvh1oy6OAU35KAWqAx570X5V4+YQCIm
	YB8ybK4A==;
Received: from [177.238.16.137] (port=49324 helo=[192.168.0.27])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1uUXuJ-00000000LhW-3HeQ;
	Wed, 25 Jun 2025 16:43:51 -0500
Message-ID: <ade0c2e6-0698-4829-8c7e-cec3c486aac7@embeddedor.com>
Date: Wed, 25 Jun 2025 15:43:41 -0600
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3][next] acpi: nfit: intel: avoid multiple
 -Wflex-array-member-not-at-end warnings
To: dan.j.williams@intel.com, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang
 <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 nvdimm@lists.linux.dev, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <aEneid7gdAZr1_kR@kspp> <202506250950.31C8A58E@keescook>
 <e0adad17-5d4f-4309-9975-81971597da65@embeddedor.com>
 <685c5d0062f2b_1608bd10051@dwillia2-xfh.jf.intel.com.notmuch>
 <685c653a6fe42_1608bd100d0@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <685c653a6fe42_1608bd100d0@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 177.238.16.137
X-Source-L: No
X-Exim-ID: 1uUXuJ-00000000LhW-3HeQ
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.27]) [177.238.16.137]:49324
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfH9/bRHKJTHQtkIxB/FcR5N0DE3ZkhIewSNEDxEC0C/RHRcvPaBycMu3Sko535Y9j41IhyC5ijZaau6plqnMaVt9rkPOdS/rFk8s8a0C4gqGmV5nTS/N
 PWCiILlGjS8Iy6PMv2bq8XYOY44rr26in+uH8ERm+llDsXR8CV80rqndvW66kZ/77vT6HQd3nbDgoFAXC8CjOjppNI5H5L9qX/6OMe++KTRHog9pstLjImwA



On 25/06/25 15:08, dan.j.williams@intel.com wrote:
> dan.j.williams@ wrote:
>> Gustavo A. R. Silva wrote:
>> [..]
>>>> I think it would be a pretty small and direct replacement:
>>>>
>>>> 	TRAILING_OVERLAP(struct nd_cmd_pkg, pkg, nd_payload,
>>>> 			 struct nd_intel_get_security_state cmd;
>>>> 	) nd_cmd = {
>>>> 		...
>>>
>>> Yes, this works. Hopefully, maintainers will comment on this and let us
>>> know what they prefer. :)
>>
>> Hey Gustavo, apologies for the latency here. I think TRAILING_OVERLAP()
>> looks lovely for this if only because I can read that and have an idea
>> what it means vs wondering what this _offset_to_fam is about and needing
>> to read the comment.
>>
>> If you can get me that patch on top of the TRAILING_OVERLAP() branch I
>> can test it out and ack it to let it do in through the KSPP tree.
> 
> Just to move this along, I gave this conversion a try and all looks good
> here. So feel free to fold this in and add:
> 
> Acked-by: Dan Williams <dan.j.williams@intel.com>
> Tested-by: Dan Williams <dan.j.williams@intel.com>
> 
> ...and take it through the KSPP tree with the TRAILING_OVERLAP() merge.

Thank you, Dan! :)

-Gustavo

