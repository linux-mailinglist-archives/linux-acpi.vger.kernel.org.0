Return-Path: <linux-acpi+bounces-21387-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8ItgLWwEqWlW0QAAu9opvQ
	(envelope-from <linux-acpi+bounces-21387-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 05:19:56 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 34DDB20ABDE
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 05:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 163C730579FE
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Mar 2026 04:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A440A1E3DCD;
	Thu,  5 Mar 2026 04:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="I499EJBH"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1841A4F3C
	for <linux-acpi@vger.kernel.org>; Thu,  5 Mar 2026 04:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772684294; cv=none; b=Kg0IaewOvW6ACcG80tetedAVwxIYOlmfS4CHwwMsRIcQAQSbdujWcC0MyjLUkkrY0ZmZbvbidAbe7zEBZO9vibeihKIZylklZNZPQrDhoVIm00w3uy4Keac3H8bdpulZVbFgz0GESibWMK6mq/ccjE8w5Wwt8emLUPAS6e2Z8sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772684294; c=relaxed/simple;
	bh=xqEUrDrHuTsX7BOEBaGNgotXQMrlUkf2uviuVaMzWjo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s2b/TkY/r35/0VEOcKT+vCj/jlP1/W7G7oHXvpXM63ncb0OCj4Qsw8xTrMxlzmViUcUwLDF5nFQt1EgCZvsk7Cw5wy4irV95sJYZ/XSNsUymClEJLTCMaYmwTNHa4SvR26G7E9YQHyOTvxwPtGG2Navcpf2f5fnqDXDnIzhnI5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=I499EJBH; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-359863611faso1756975a91.3
        for <linux-acpi@vger.kernel.org>; Wed, 04 Mar 2026 20:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1772684293; x=1773289093; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ex5BiGy9sdTtbNN9/uQGHuy877qSLSxuqy2llH/Sfzc=;
        b=I499EJBHfCx3nVfNnlm5d9YSZNmpWFq0BUAKsuLimXNimWNAl+aWEylCQ3JyfqTmgt
         Eyxty/pkibTJaFwNY14PQ9mBwETzUktxo706Yo175idZimSveH19O5+s8opC1hCQOp4p
         0L2SOaGy8Gd9/7hM8beXdtyr1b7wM/I5jfolBXFqV3xYv1SHR0bakJYtqF1PQKeW8V+A
         yxLTxL4LEyI/hVLATEjlKfRxzWbWoBLHwAtNxJMqDZmg3uMwrvVI0n5TYjyNZuDPEhIq
         0Jdbi+w4+3dsoU5/i+aJuPJ8++g+RT2FYyodcdxyOOma24xpbETcbQGo2SJAg4rzoucM
         1sSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772684293; x=1773289093;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ex5BiGy9sdTtbNN9/uQGHuy877qSLSxuqy2llH/Sfzc=;
        b=AlezCpVcMLutlY1nfr87A4IS5C48Ji2DBV3Z7wSNWVNAzFV+7U1mAlhCXpjbh4trS0
         uaRn76tZ7lrgKnB2ApABU5jZ+JcwfzCBQlvz5xvZPwhmvtpK3QyKwTBlrvinrChOeD1Q
         ue1/lNqSpds2N+ukI8pf5iJUggwrjrPK6EghAA1q67wNbhfR35P2+FrDcAWWZtGh4fB7
         cq6P8NW62LFfawlT+HARChTm0m/Yl6Dz9BDl2QnYkHHNMftT6UUxz6UARjCjuH821f/v
         1ZWY3dWHGctxjTmc2SSq1f4PKWAdtGyo3L5snAviJfqYpK0LmjHTIxUjgetSvRTWAyaX
         DokA==
X-Forwarded-Encrypted: i=1; AJvYcCXxpr+e67aPaZFCp7iOSzkLM7jhQrOBtBMvhx3IH54YtRjhXNvguDB9sWcPDgOhcwug+ft18UJEjeDU@vger.kernel.org
X-Gm-Message-State: AOJu0Ywnq4O5W3Q00A87RccpQI5uqbaCkkyPkBBFSZbuoscqSj2wP8Kp
	rTTw1Wn71XWf+zowiqINe3+qxp4kSdDA0j0PF3XJnDFQ9JV1lQ9U5Z7rVebFplPVJUo=
X-Gm-Gg: ATEYQzyIaQVkkqkbWU4pePdPQkI0UyTjhwjK5gfoYqTQbX8esCwKcBHKn/laYL4l7KW
	LCkne4pT8pyl0sKC3QlmIv6U1QYxKuxJNsvXi0wxKSwpcYmVrLahkebDzcOGkHYhDMo/cv6n9tw
	G9csByU+E/ZKseKAxYfoLhH3rlqzg/eum7KKCMXZWpFzlHnf9QmDSAXx8XYYH9Yyn9CG2Xuy/Oi
	KhupxR77cvUG3Q0vpnUWYnhgz2N4syhhv3VH4Z5dLHigfHCpT7uKQTxcg8aZu+ihJZjDBqDwenJ
	e9+A0C7mJJ79sID8u2xsiBUtmhjR9g7tdrYb1PS5CXmOtqNazbu3lBQzMR3esruPCHooJLMbDKC
	9+MVg+KZN+IVZoAFVX1O9oVxbFNEtAfZ0vw7LKXhVBr8pA5kXGWiaUZ6w0nHkNytINP03i8oywM
	rx5pkNXsMgo0kiAWNgWq7SXrdo0qIvf+9v/yZY+/hudgchNKuNHCJfvczFF6U94bhfkhn9lNfye
	BOPJ7/5lWIBYoGs2Rm7Ow==
X-Received: by 2002:a17:90b:1c10:b0:352:d59a:b28 with SMTP id 98e67ed59e1d1-359a6a4f86amr4022402a91.19.1772684292685;
        Wed, 04 Mar 2026 20:18:12 -0800 (PST)
Received: from [10.54.26.107] (static-ip-148-99-134-202.rev.dyxnet.com. [202.134.99.148])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359b2dffbf2sm459828a91.13.2026.03.04.20.18.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2026 20:18:12 -0800 (PST)
Message-ID: <8ad398f6-995a-489b-8ca2-f21afdce47e4@shopee.com>
Date: Thu, 5 Mar 2026 12:18:05 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: add a boot parameter to disable parsing CFMWS
 during NUMA init
To: Gregory Price <gourry@gourry.net>
Cc: rafael@kernel.org, lenb@kernel.org, dan.j.williams@intel.com,
 jonathan.cameron@huawei.com, dave@stgolabs.net, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260304080647.169434-1-haifeng.xu@shopee.com>
 <aaho0IyQ0WAjcRMM@gourry-fedora-PF4VCD3F>
From: Haifeng Xu <haifeng.xu@shopee.com>
In-Reply-To: <aaho0IyQ0WAjcRMM@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 34DDB20ABDE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[shopee.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[shopee.com:s=shopee.com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-21387-lists,linux-acpi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[shopee.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haifeng.xu@shopee.com,linux-acpi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-acpi];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action



On 2026/3/5 01:16, Gregory Price wrote:
> On Wed, Mar 04, 2026 at 04:06:47PM +0800, Haifeng Xu wrote:
>> For the machine Intel(R) Xeon(R) 6746E that supports CXL memory,
>> the possible nodes are 20 (0-19). However, only two numa nodes (0-1)
>> have memory and the rest nodes (2-19) detected by CEDT are memoryless.
>>
>> The problems is that when creating many pods, the shrinker map size
>> needs to be expanded for all memory cgroups in expand_shrinker_info().
>> If the number of possible nodes is too large, the holding time of
>> shrinker lock grows significantly.
>>
>> In this case, there is no CXL memory inserted in the machine, those
>> memoryless nodes are useless for us, so there is no need to set them
>> in 'numa_nodes_parsed'. After disabling parsing CFMWS, the pod creation
>> time is reduced from over 10 minutes to approximately 150 seconds in
>> our internal test.
>>
> 
> This seems like the wrong scope to fix the underlying problem - which is
> the shrinker lock holding scope.

Hi Gregory，
	
Thanks for your comments. 

Every memcg records shrinker info for each possible node. If we use online node
instead of possible node，then during memory hotplug, we must tarverse all memcgs
and shrinkers to check whether corresponding node has allocated the shrinker_info.
This way introduces more complexity.


> 
> If you're not actually using CXL, can't you just disable CXL in the
> BIOS?  Then you shouldn't even emit CFMWS at all.

I have asked our Intel Support Engineer, he saied that cxl can't be disabled
in BIOS.

If know how much nodes we actually use, can we specify the max number of pxm?

Now the pxm can't exceed MAX_PXM_DOMAINS which is equal to MAX_NUMNODES.

Thanks!

> 
> ~Gregory


