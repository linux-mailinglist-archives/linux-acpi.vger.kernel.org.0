Return-Path: <linux-acpi+bounces-11488-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 003D9A45C22
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Feb 2025 11:50:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58A22189258C
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Feb 2025 10:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7460826AA9E;
	Wed, 26 Feb 2025 10:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="u8jNnmbp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from pv50p00im-ztdg10011201.me.com (pv50p00im-ztdg10011201.me.com [17.58.6.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B7920E32A
	for <linux-acpi@vger.kernel.org>; Wed, 26 Feb 2025 10:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740566984; cv=none; b=pYA+YABVUpbgBizpJGyXqPR3ONi7nSbCzBGNM2MlhJ2NsGkkf39TJaMuVMykxPOoialQn7zzx3rQlqNSu0VpCeZwLNtcTqKmKPy8KPvSkUrD/IRgM1s75rC7Yc33AeCDgFI4C0M4jfAjAPBIPg6oFjN7pYpNPNUl4ZOBfNDnZwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740566984; c=relaxed/simple;
	bh=/ksErclY+a2HfY+n6eyQP1xvxnb1/u05wmeZJj/ugy0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oEXi6zGIvtMn9ZBdUffWOZSGxzgX1+nPc8sqkGhWCEDV22dZFJHpZMav+400aG9RA3PtHr/Y+eq73hvwwl7vVHHCFJtAR8sGpLW9Yb8f5TNTm4Ha0SMfx7QNkNTLPTMZjt3WIm1VBYyzgLsK9pM4lUOUsCJcCg+nphGdWmHnHLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=u8jNnmbp; arc=none smtp.client-ip=17.58.6.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=rZ/JKLqvgcs6sxz9YBuHcFMLh6kDf+x72Yif1lbgen4=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:x-icloud-hme;
	b=u8jNnmbpJbeehjrSua28dZ0/xMaBJoS73delakyASdo1yTPjiYiMhTZHl5m6a6D/Y
	 uCkpbNxVjfvP09X8stV6LlLFTwwVJa8Ygzr2SdyFIZT2gzSr2Iq7cScxglsLfz+T8F
	 RQt/ZThY+PMDeI48gg6gWlAOc3iR7Hj/4duOAzfxJz9xfFIhwz5ZUXU5YusMcBvFDV
	 mN2zsXCGGiHn80xrDB6nHQ5JYm0V0D9TPFeL3k9FBsL0gmJhVaFyDERWQUzkfCqSZN
	 kqvITJUr2BS1RYcNJUP9LTZ5/bv0FgMlIsH2a8c77mo9uTSojeII0oo3eNz7vJXkSR
	 Ac0H71kX+3eCA==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10011201.me.com (Postfix) with ESMTPSA id 2A81168011A;
	Wed, 26 Feb 2025 10:49:34 +0000 (UTC)
Message-ID: <aa24e5cf-3a32-4792-be0f-9b8d190730d2@icloud.com>
Date: Wed, 26 Feb 2025 18:49:31 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] of: Align macro MAX_PHANDLE_ARGS with
 NR_FWNODE_REFERENCE_ARGS
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Daniel Scally <djrscally@gmail.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>,
 Saravana Kannan <saravanak@google.com>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Zijun Hu <quic_zijuhu@quicinc.com>
References: <20250225-fix_arg_count-v4-0-13cdc519eb31@quicinc.com>
 <20250225-fix_arg_count-v4-2-13cdc519eb31@quicinc.com>
 <Z73RssDaLZ1NLpSZ@smile.fi.intel.com>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <Z73RssDaLZ1NLpSZ@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 05sHnAVq0PQ3X_GllbBMIWh8EHQfvioA
X-Proofpoint-ORIG-GUID: 05sHnAVq0PQ3X_GllbBMIWh8EHQfvioA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-26_02,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 clxscore=1015
 mlxlogscore=760 phishscore=0 mlxscore=0 adultscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2308100000 definitions=main-2502260086

On 2025/2/25 22:20, Andy Shevchenko wrote:
> I would add here that the of.h includes fwnode.h already, so it doesn't
> add any new compile time dependency.
> 

thank you Andy for comments.

include/linux/of.h:
struct device_node {
...
	struct fwnode_handle fwnode; // this type is defined by fwnode.h
...
}

include/linux/fwnode.h:
struct fwnode_handle {...}

So of.h must include fwnode.h


Perhaps, of.h needs to include fwnode.h *explicitly* even if this is
another topic.

> Both patches LGTM,
> Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>


