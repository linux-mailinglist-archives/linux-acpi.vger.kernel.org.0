Return-Path: <linux-acpi+bounces-16529-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F025B4AA90
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Sep 2025 12:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A413F5E0714
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Sep 2025 10:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E563191B4;
	Tue,  9 Sep 2025 10:26:16 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA132D3EC5;
	Tue,  9 Sep 2025 10:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757413576; cv=none; b=GbaQIi/1rsdr3ktdeAAN49wEgbdya8kUc5ucrcnfoktyS4YKePCsfXsWGCT3eGgKBbUVRPWFFCmhaL3g3FgmsH/oADtU2wuJgZzqD/NdHAsoqL+XlFb3DPFYiFAywlA8vUd/DXVEWyj2DEetATl709j+LdhbLot3VpwoLg/XzfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757413576; c=relaxed/simple;
	bh=Q3Kp9eto2xFOc1OFfv9ITTgheZnnDyXo8YEz28FwXBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gvDwdlHDP4/oEm5hJLHS1yCy8bZU0xLbHY/2tf2f3hdWoMJgNR1UjyxCLA/+Jel+8wFmxuM/A+jiev1Gcm7Hg/eUz/m8Vl8xgEBeaeX+Uu7mkHNyupEB5/5R97c87m5/pIgxBqX6j/awajSFuE1szxiPRbX24TmRxLaw4jn+Tps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B85C3113E;
	Tue,  9 Sep 2025 03:26:05 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.68])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3CDB83F66E;
	Tue,  9 Sep 2025 03:26:08 -0700 (PDT)
Date: Tue, 9 Sep 2025 11:26:05 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: James Morse <james.morse@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
	shameerali.kolothum.thodi@huawei.com,
	D Scott Phillips OS <scott@os.amperecomputing.com>,
	carl@os.amperecomputing.com, lcherian@marvell.com,
	bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
	baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
	Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
	dfustini@baylibre.com, amitsinght@marvell.com,
	David Hildenbrand <david@redhat.com>,
	Rex Nie <rex.nie@jaguarmicro.com>, Koba Ko <kobak@nvidia.com>,
	Shanker Donthineni <sdonthineni@nvidia.com>, fenghuay@nvidia.com,
	baisheng.gao@unisoc.com,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Rob Herring <robh@kernel.org>, Rohit Mathew <rohit.mathew@arm.com>,
	Rafael Wysocki <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH 07/33] arm64: kconfig: Add Kconfig entry for MPAM
Message-ID: <aMAAvXz0zWqoiGm4@e133380.arm.com>
References: <20250822153048.2287-1-james.morse@arm.com>
 <20250822153048.2287-8-james.morse@arm.com>
 <aK7llvNbXZKWhtoo@e133380.arm.com>
 <978cf822-4d7c-4301-bbc4-752f184c93d6@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <978cf822-4d7c-4301-bbc4-752f184c93d6@arm.com>

Hi,

On Thu, Sep 04, 2025 at 06:28:14PM +0100, James Morse wrote:
> Hi Dave,
> 
> On 27/08/2025 12:01, Dave Martin wrote:
> > <super-pedantic mode enabled>
> 
> Uh oh!
> 
> > (Since this likely be people's go-to patch for understanding what MPAM
> > is, it is probably worth going the extra mile.)
> > 
> > On Fri, Aug 22, 2025 at 03:29:48PM +0000, James Morse wrote:
> >> The bulk of the MPAM driver lives outside the arch code because it
> >> largely manages MMIO devices that generate interrupts. The driver
> >> needs a Kconfig symbol to enable it, as MPAM is only found on arm64
> > 
> > Prefer -> "[...] to enable it. As MPAM is only [...]"
> > 
> >> platforms, that is where the Kconfig option makes the most sense.
> > 
> > It could be clearer what "where" refers to, here.
> 
> Sure,
> 
> 
> > Maybe reword from ", that is [...]" -> ", the arm64 tree is the most
> > natural home for the Kconfig option."
> > 
> > (Or something like that.)
> 
> Sure,

[... etc., etc. ...]

> >> +	  partition-id and performance-monitoring-group to measure the
> >> +	  cache occupancy or data throughput.
> > 
> > So, how about something like:
> > 
> > --8<--
> > 
> > 	  Memory system components, such as the caches, can be configured with
> > 	  policies to control how much of various physical resources (such as
> > 	  memory bandwidth or cache memory) the transactions labelled with each
> > 	  PARTID can consume.  Depending on the capabilities of the hardware,
> > 	  the PARTID and PMG can also be used as filtering criteria to measure
> > 	  the memory system resource consumption of different parts of a
> > 	  workload.
> > 
> > -->8--
> 
> Done,
> 
> 
> > (Where "Memory system components" is used in a generic sense and so not
> > capitalised.)
> 
> (I can't wait for the Memory System Component on the Memory Side Cache!)

Urk.

MSC² ?

[...]

Cheers
---Dave

