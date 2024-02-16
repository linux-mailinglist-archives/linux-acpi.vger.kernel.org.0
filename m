Return-Path: <linux-acpi+bounces-3586-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E93857C3D
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Feb 2024 13:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80B8228438F
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Feb 2024 12:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD6177F12;
	Fri, 16 Feb 2024 12:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PTK3ppTP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA96654F9F
	for <linux-acpi@vger.kernel.org>; Fri, 16 Feb 2024 12:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708084937; cv=none; b=LipL2tlzMYqMecdyYRZdxeI5RfdzR1IS20cgf9d1IRKEnelqgBMl3tcAxLlY6DKJAODgqlJ5UFGkzH7GJFggEEzmR+SRjzMxZaF8fKSAkQxGPhdjXWgZp0OwTN0ScfZCbsm0lZMIfBegGdvdG48xYCoggu2c0D02AaJTYPmcZnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708084937; c=relaxed/simple;
	bh=J2oFmoOn1neDKKiCbsbb1mhSR2tPMZjMZqn2yB/NxFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M09yBODXt6nSkytAXqLX9/kbJiRYoRIYE3AOLQfrSVPr+i1NLIqpAUvyYQfeB+tIfiyEc5fpdr00ycHhNTyLK3QS5qmJ/bzU5xHuUSL6KFxzUFXOON/AN/Z+ihfTbfSp4OjynLiItisrB0ORT2ikA1c1pKvk9esK/SozkVCk8mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PTK3ppTP; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708084936; x=1739620936;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=J2oFmoOn1neDKKiCbsbb1mhSR2tPMZjMZqn2yB/NxFk=;
  b=PTK3ppTPdzBEoiXGSLNYT8+nc4uanHlKRjmFVG3PHtZ0vQcHnHTYPwhB
   BVFwdQ+Us8RPEjWtI/1WjHmA7q3ez/q3eQr/haBqgjYao9P+Fdmw/xEul
   +1pv70/7G179PawVGa3Imn6SSoq4YjkOSlJyRW51u8XipcKnA882Heha2
   OUJ3J0Sz02EDc0RHQ+AvJ5gW9iT61a83suJ2jzPqUC7Y69Gksxl9SbJxw
   uevIU+wssjA51sCZEz8fS1xlWLWZ9/keO18QP07Hj+b8PcuXcJ+TBHCoj
   8nVgK291gw2cq0wX//WUvaqnlSM9eOtrMC6xTmzcUmAqYVGx8YqJrqYDm
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="12836594"
X-IronPort-AV: E=Sophos;i="6.06,164,1705392000"; 
   d="scan'208";a="12836594"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 04:02:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="826571231"
X-IronPort-AV: E=Sophos;i="6.06,164,1705392000"; 
   d="scan'208";a="826571231"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 16 Feb 2024 04:02:13 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 8D2EE2CB; Fri, 16 Feb 2024 14:02:11 +0200 (EET)
Date: Fri, 16 Feb 2024 14:02:11 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: aigilea <i@cpp.in>
Cc: Robert Moore <robert.moore@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev
Subject: Re: Kernel panic in ACPICA on HP Spectre X360 (Meteor Lake 155H)
 laptop
Message-ID: <20240216120211.GR8454@black.fi.intel.com>
References: <CABYkuAg3rcXT=0-=7EMX8NW3-mU0zYRvp+rOo5nq_7SHdb=cxA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABYkuAg3rcXT=0-=7EMX8NW3-mU0zYRvp+rOo5nq_7SHdb=cxA@mail.gmail.com>

Hi,

On Fri, Feb 16, 2024 at 10:33:00AM +0300, aigilea wrote:
>    Hello.
>    I've run into a problem with ACPI while trying to run any linux
>    distribution on "HP Spectre x360 14 inch 2-in-1 Laptop PC 14-eu0000" with
>    the latest BIOS "F.05 Rev.A" with kernel versions from 6.5 to 6.7.
>    During the boot or shortly after kernel spits out a crash backtrace
>    originating at "acpi_ps_get_arg" called from "acpi_ps_delete_parse_tree"
>    or at "acpi_ps_delete_parse_tree" itself.
>    It usually results in a panic and the system is halted but in some rare
>    cases it continues to work for some random period of time so I was able to
>    collect some debugging information.
>    I'm attaching parts of the log I've got booting Arch 2024.01 liveusb with
>    kernel 6.6.8 with the following command line:
>    acpi.debug_layer=0x30 acpi.debug_level=0x880640 log_buf_len=256M
>    dyndbg="file device_pm.c +p"
>    Layer is ACPI_PARSER | ACPI_NAMESPACE, level is ACPI_LV_PARSE_TREES |
>    ACPI_LV_EVALUATION | ACPI_LV_NAMES | ACPI_LV_EXEC | ACPI_LV_PARSE
>    I wasn't able to boot more recent kernels to a working state to collect
>    the log but they panic in the very same code.
>    Log part with crash starts at "ACPI: \_SB_.PC00.I2C3: PM: Power state
>    change: D0 -> D3cold" because I think this is what triggers the problem
>    and the crash happens after what looks like a double call of
>    "ps_delete_parse_tree" from "ps_pop_scope" with the same subtree_root arg
>    which should result in use-after-free and a double free.

We have seen similar and I think this should be fixed in the BIOS side
but I'm checking internally if this is the case or what was the
conclusion.

Temporary workaround is to blacklist intel_lpss_pci driver (although you
may lose some of that functionality then but that's still better than
completely non-functional system).

