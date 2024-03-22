Return-Path: <linux-acpi+bounces-4431-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A429C8872B8
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Mar 2024 19:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 448051F25886
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Mar 2024 18:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B3563099;
	Fri, 22 Mar 2024 18:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mjTgzcPa"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECED629F8
	for <linux-acpi@vger.kernel.org>; Fri, 22 Mar 2024 18:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711131148; cv=none; b=jxQlnA2GDeEbmkSIqHK8sfnEvjgznAudnSsTMG8Mjd3UUal7nD8uaMbBpvWNmC9/BZZkAAv/O0S65th22HhOzetErwxYiiODufALWZj3ppEMeJZQG744U05I54Wl95oQwsnS2aw1+vhWnjerkWi6WO9lIc2MelZt7fI2P7z2Yyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711131148; c=relaxed/simple;
	bh=W+fx4MS4or2BP/f0GWe+w1c2YvtMTPRiTmEWfMajIFY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YrB6nXqU9w47oT5NfJfm+5Vf8PQCzcVOv+Wu0IXYetLphkbBtlAtInU2tOdZtMiOd88klO24PtgqKAa2+LRPLmVf5lzEpJc1jvuZ+0jUyHQH1lRaLnqCh9Reu8WMRHvCM19iU7uVrgMuVa/4D3a4DxoqtYAobEpvtLrIZ0zqTyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mjTgzcPa; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8afe3f27-fc8e-4c20-ba28-74a0a2937e55@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711131142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PZ1o/opYgIzUM1VjnrIvbzSw8b5obvxKpmvvVITsLf8=;
	b=mjTgzcPaCGTKrFIbb5VFUgckqJQPFwF4J2IqEZlCeLZ4YdntK5hU3jzMtZzeKeYxEweGHg
	aXZKlfPzifwlDEypUEeySV6VeTgrLUqUSJLwx1RW+FBSJoUymkNiFjVn57GFE4Pw5XtgbV
	ixbap/jrFX5VGq9mcPiZ7UO5RBKlj9g=
Date: Sat, 23 Mar 2024 02:12:14 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] software node: Implement device_get_match_data fwnode
 callback
Content-Language: en-US
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
 Daniel Scally <djrscally@gmail.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-acpi@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Vladimir Oltean <vladimir.oltean@nxp.com>
References: <20240318234222.1278882-1-sui.jingfeng@linux.dev>
 <Zfq85f-Dp1S3CKuG@smile.fi.intel.com>
 <9ced20e0-dfbd-4337-b5df-223b7baffd9e@linux.dev>
 <ZftG6Q5AaG71dhWq@smile.fi.intel.com>
 <9644da91-f367-4083-a3e4-4d0677c8cbca@linux.dev>
 <Zf2uUwcMgIpo6rVh@smile.fi.intel.com>
 <6bf102a4-6419-4083-8918-4f7c76cfa9a1@linux.dev>
 <Zf3IWyrW8IZLTg4x@smile.fi.intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <Zf3IWyrW8IZLTg4x@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi,


On 2024/3/23 02:05, Andy Shevchenko wrote:
>   Besides that, the kernel project rule is "we do not add
> the dead (unused) code".


This rule is good an correct and I admit.

But the problem is that it is chicken-and-egg problem,
it probably have at least two user now.
it's possible that it will gain more users in the future.

But if you reject everybody from now, then it is zero.


-- 
Best regards,
Sui


