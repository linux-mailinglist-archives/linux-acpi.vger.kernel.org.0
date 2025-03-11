Return-Path: <linux-acpi+bounces-12063-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6C9A5B80A
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Mar 2025 05:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA3A23B012B
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Mar 2025 04:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21AA01EB5DC;
	Tue, 11 Mar 2025 04:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="CSMQ1Si0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8181EA65
	for <linux-acpi@vger.kernel.org>; Tue, 11 Mar 2025 04:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741668176; cv=none; b=PhUX0x6zFF3x5LBtHiWfPv6mFu87Fini+VX5RCBlELRkDf2XzR1L7AZdwffPwVjPXM5PIezCdjzKehbOE8Govgzkn8LZi4aIu6K/5VoAATOL/BPcooz4fArKuNfMKRj2IPv0hx/PHBzWBJww8x7cCoOvgFB15Iz+y5YdmIIN0/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741668176; c=relaxed/simple;
	bh=ZIXYbx99GWcU3m4RbCBFujbcjDEGf3CVOkhBYhq9nNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dcf4PfNwpgThI1gLw0Y8K0kbkpZPzQ9dGXIGoRNf1OX77fI2R2DSdHFaXz+3BilNxoiGD+8+BjU2CLURycm6kMrEQ0xIxSQ8I9fAM1j6fL8AKG+F2+zJI8aydXokPoD3mLZRDABvVXuHNHYWobt8PL1oXAMZkzgw6JdKzbcFCmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=CSMQ1Si0; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c554d7dc2aso245573585a.3
        for <linux-acpi@vger.kernel.org>; Mon, 10 Mar 2025 21:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1741668173; x=1742272973; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yggy5E5nMEcdAw0yO3eFHyu+/DXmHOC/abpMBj8KMA4=;
        b=CSMQ1Si0EPmH1myUT/xTUEJNDQtbsFa+EkdCIcvRHdbPDFFvp5GzhqUwD1LzfgBi8h
         4JevWIXTINuSYmHiPoQ9ZAiuM1OSOMdUArcheEPaE1ohNsJIUTdY6Svhfl8uNKcFY3XU
         WgJF2GeNw6poz0LD7AKGBy1K204CrMG/19SxejUJ3LvvbCokf6YEm49qdio2w7/Z3iMB
         cetCBqExqiwtqnnMj43SIGv8fknh9dV7gTfacfEFbsO6mHxETaf/sCco1XGYKlr8Yk8t
         eB+vYQs27SbFNI0tycydh0RT/7EY8Ra0izY+k+u9JMXlsZmR+++v2LlvdlsgTyJPrMvp
         5y6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741668173; x=1742272973;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yggy5E5nMEcdAw0yO3eFHyu+/DXmHOC/abpMBj8KMA4=;
        b=pALojfgUop2tcGN1HPlsx7IYnZ8/OtRtFMG07m8BN007PVpo2sVN0QqlQUKkPyR9Nq
         wqdlq6071c0E+dcz9v8hjwr8lcBp4EVIlH89pax70kn6Vpodh+dXq2+dE89ZEu6b1xNH
         EchYJ+3zUMnKNLUjwi5c5Jw64jgFPuQuevU9DTlADSCnBKyfWAbYmaK3roBMA9wcUNqg
         iirhaLg47HxSWD4DJKFGSiX9Gbg1kU79H+qdkCCLoe2d2eo3nx4EWQyC1j5Ltrsv6Gd4
         rahr0s64NkEuoyxrqDkLtucAqKQqTkvY6IX5scmq55eS2zUE4BMmW241g09lCbC6C88P
         ++nw==
X-Forwarded-Encrypted: i=1; AJvYcCW00xbCHGP3R3xBgEYJXGlC4JK9Wo8lDy5iqjoXregX92A5Iq3A6n72EypYBTFhYpqg9QVmbsAzheKa@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh5VpIZCd/o3/oxlond44TWl7w21AcGtAZzZ+VcARJQzfl4apm
	ld2/a6ybriSeUluLfgoeN8K8/ashdTGNTgG7MEIHIkE1akcDMVDzn6UiCB+Tte5C74adwm86nAS
	x
X-Gm-Gg: ASbGncu646tz08QbBgJv1aGc5kRvY6OEyFjXbE0jidjpTaSH4JGsyPob9V6q3tKU5Ul
	HWbMAN3wwC/p/maDraSJYvRlxonyCy9a3wnKWugyH5K17KJJceD7ifqarNELqcT6DH+gacQ5VGX
	evH+J8UmGGxfEqDC0uDUmvYRxYCbtsj9CVoHugb2B+NHFuR6LGe2ebNRu8tXYwqNJXKvf9bfFu6
	2mLzIjVyeFk6wjl+C6ctxqO5DlAV94vtmz/QsEmc1AHZz+VpoHNYItOLytOlGX8rC+ISvGPzhg3
	+anLKho3H8vYHHGtfRnv1LuOJFeeptCSt/RJi6TOkLaohmNrdxSviPjFqUE5YMFKGjd8wLqUspX
	fSQipusaezJLhh7YvlyRnQQJg2/M=
X-Google-Smtp-Source: AGHT+IE3DXDoXpaGabxCNGVv6brJLbyVLodPXFyApwSTWHeoS6ie+LPjHb7T5fwZkKUirni5TTUSjw==
X-Received: by 2002:a05:620a:8803:b0:7c5:5a97:f784 with SMTP id af79cd13be357-7c55a97f9fbmr560057085a.33.1741668173210;
        Mon, 10 Mar 2025 21:42:53 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c54f33d3bbsm324043985a.45.2025.03.10.21.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 21:42:52 -0700 (PDT)
Date: Tue, 11 Mar 2025 00:42:49 -0400
From: Gregory Price <gourry@gourry.net>
To: Yunjeong Mun <yunjeong.mun@sk.com>
Cc: kernel_team@skhynix.com, Joshua Hahn <joshua.hahnjy@gmail.com>,
	harry.yoo@oracle.com, ying.huang@linux.alibaba.com,
	gregkh@linuxfoundation.org, rakie.kim@sk.com,
	akpm@linux-foundation.org, rafael@kernel.org, lenb@kernel.org,
	dan.j.williams@intel.com, Jonathan.Cameron@huawei.com,
	dave.jiang@intel.com, horen.chuang@linux.dev, hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-mm@kvack.org, kernel-team@meta.com,
	Honggyu Kim <honggyu.kim@sk.com>
Subject: Re: [PATCH 2/2 v6] mm/mempolicy: Don't create weight sysfs for
 memoryless nodes
Message-ID: <Z8-_SXm0JGjXTegL@gourry-fedora-PF4VCD3F>
References: <Z8-jLIugrb86KBSZ@gourry-fedora-PF4VCD3F>
 <20250311040252.425-1-yunjeong.mun@sk.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311040252.425-1-yunjeong.mun@sk.com>

On Tue, Mar 11, 2025 at 01:02:07PM +0900, Yunjeong Mun wrote:

forenote - Hi Andrew, please hold off on the auto-configuration patch
for now, the sk group has identified a hotplug issue we need to work out
and we'll likely need to merge these two patch set together.  I really
appreciate your patience with this feature.

> Hi Gregory,
>
> In my understanding, the reason we are seeing 12 NUMA node is because
> it loops through node_states[N_POSSIBLE] and its value is 4095 (twelves ones)
> in the code [1]  below:
> 
... snip ...

Appreciated, so yes this confirms what i thought was going on.  There's
4 host bridges, 2 devices on each host bridge, and an extra CFMWS per
socket that is intended to interleave across the host bridges.

As you mention below, the code in acpi/numa/srat.c will create 1 NUMA
node per SRAT Memory Affinity Entry - and then also 1 NUMA node per
CFMWS that doesn't have a matching SRAT entry (with a known corner case
for a missing SRAT which doesn't apply here).

So essentialy what the system is doing is marking that it's absolutely
possible to create 1 region per device and also 1 region that
interleaves across host each pair of host bridges (I presume this is a
dual socket system?).

So, tl;dr: All these nodes are valid and this configuration is correct.

Weighted interleave presently works fine as intended, but with the
inclusion of the auto-configuration, there will be issues for your
system configuration. This means we probably need to consider
merging these as a group.

During boot, the following will occur

1) drivers/acpi/numa/srat.c marks 12 nodes as possible
   0-1) Socket nodes
   2-3) Cross-host-bridge interleave nodes
   4-11) single region nodes

2) drivers/cxl/* will probe the various devices and create
   a root decoder for each CXL Fixed Memory Window
   decoder0.0 - decoder11.0  (or maybe decoder0.0 - decoder0.11)

3) during probe auto-configuration of wieghted interleave occurs as a
   result of this code being called with hmat or cdat data:

void node_set_perf_attrs() {
...
	/* When setting CPU access coordinates, update mempolicy */
	if (access == ACCESS_COORDINATE_CPU) {
		if (mempolicy_set_node_perf(nid, coord)) {
			pr_info("failed to set mempolicy attrs for node %d\n",
				nid);
		}
	}
...
}

under the current system, since we calculate with N_POSSIBLE, all nodes
will be assigned weights (assuming HMAT or CDAT data is available for
all of them).

We actually have a few issues here

1) If all nodes are included in the weighting reduction, we're actually
   over-representing a particular set of hardware.  The interleave node
   and the individual device nodes would actually over-represent the
   bandwidth available (comparative to the CPU nodes).

2) As stated on this patch line, just switching to N_MEMORY causes
   issues with hotplug - where the bandwidth can be reported, but if
   memory hasn't been added yet then we'll end up with wrong weights
   because it wasn't included in the calculation.

3) However, not exposing the nodes because N_MEMORY isn't set yet
   a) prevents pre-configuration before memory is onlined, and
   b) hides the implications of hotplugging memory into a node from the
      user (adding memory causes a re-weight and may affect an
      interleave-all configuration).

but - i think it's reasonable that anyone using weighted-interleave is
*probably* not going to have nodes come and go.  It just seems like a
corner case that isn't reasonable to spend time supporting.

So coming back around to the hotplug patch line, I do think it's
reasonable hide nodes marked !N_MEMORY, but consider two issues:

1) In auto mode, we need to re-weight on hotplug to only include
   onlined nodes.  This is because the reduction may be sensitive
   to the available bandwidth changes.

   This behavior needs to be clearly documented.

2) We need to clearly define what the weight of a node will be when
   in manual mode and a node goes (memory -> no memory -> memory)
   a) does it retain it's old, manually set weight?
   b) does it revert to 1?

Sorry for the long email, just working through all the implications.

I think the proposed hotplug patch is a requirement for the
auto-configuration patch set.

~Gregory

