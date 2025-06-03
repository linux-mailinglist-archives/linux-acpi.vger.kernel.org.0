Return-Path: <linux-acpi+bounces-14087-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DFEBACCA5D
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Jun 2025 17:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA26B16D479
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Jun 2025 15:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6391023D284;
	Tue,  3 Jun 2025 15:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JXngNVYy"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D95123D283;
	Tue,  3 Jun 2025 15:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748965337; cv=none; b=lRQJFaXLLCabtdz29YFAGTRsLlqaROBZ3tjdtouqAg3Jf1NugJScyCMw1MkERgetP2NwC6/dWmB1cKYofOcEljSjPg2Q4E5sJMU9pIAn6+kJ7pIW3sy0wjdG1WWZpL2UP35KQ09Vs6LGS32pAyOpJBY6oFEJ7MVASFxfQ7SQBoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748965337; c=relaxed/simple;
	bh=V/ETxo4tr2kN734Uv8ZtBcuFNrpUwyBX6joGngLGDPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TJ6teuHNRC8umFEtrNrv6WRHMHNzWs/I9VoTbEdXqXZYzICM1doM0B0NWptrwkx+AWfuZSK1r1MbO29AaJOFtCBJZkdwt4aaRotXOdqFE/6+ay4db7aVYsi8FvMITpOpCJyECMJeZuqB06pjvS3RkwoeQtWcF8CJFAgQzvITLYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JXngNVYy; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748965336; x=1780501336;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=V/ETxo4tr2kN734Uv8ZtBcuFNrpUwyBX6joGngLGDPo=;
  b=JXngNVYyQJ1ICekfR66xGoOsWppFPjszmWxHJpiXRddmjxbfyOyzswSA
   kVm6uyqcRzGy0u1cDkszKPsm8uKLxMeZMI8ym0VLshnN5WiwC1CUqHa2H
   ZvDO/4CGqA8j8ExZpKrwdtE7QemyiY/e2yibcbEwdvIBjzd51CUKw8VY9
   qtMDhB9jhvibTNNMN98IB47iFuiriBFE60ORzcjfm9m6RShFROhYvJD+3
   9NGjEwY7xY7bzd+yKJsQFCqN6ufZXAa1xNt0QIRyBuJGgz8Km2Bs4Ua6I
   mcO10907HpQL3Kba1GdO1iH+U4izuWr+ikUx6RAHGqsNL+5QPXd2Dy1Ui
   A==;
X-CSE-ConnectionGUID: Nm0Eecw3TGaTbMiSMtW31w==
X-CSE-MsgGUID: MFyiDQvjRzKoBLos+v+MhA==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="62403933"
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; 
   d="scan'208";a="62403933"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 08:42:15 -0700
X-CSE-ConnectionGUID: DlvhbR8QRleM29WDZWI4Rw==
X-CSE-MsgGUID: pUrUo3bLTWmyAV0CbXJX8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; 
   d="scan'208";a="149779939"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.103.51])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 08:42:14 -0700
Date: Tue, 3 Jun 2025 08:42:13 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Zaid Alali <zaidal@os.amperecomputing.com>, rafael@kernel.org,
	lenb@kernel.org, james.morse@arm.com, robert.moore@intel.com,
	Jonathan.Cameron@huawei.com, ira.weiny@intel.com,
	Benjamin.Cheatham@amd.com, dan.j.williams@intel.com, arnd@arndb.de,
	Avadhut.Naik@amd.com, john.allen@amd.com,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: Re: [PATCH v7 9/9] ACPI: APEI: EINJ: Update the documentation for
 EINJv2 support
Message-ID: <aD8X1cNBesu71yy3@agluck-desk3>
References: <20250506213814.2365788-1-zaidal@os.amperecomputing.com>
 <20250506213814.2365788-10-zaidal@os.amperecomputing.com>
 <20250530102711.GAaDmH_1O7lc6kuveY@fat_crate.local>
 <aDoal24J-BMTIBCq@agluck-desk3>
 <20250531092050.GBaDrJ8iw7cNcpOKeA@fat_crate.local>
 <aDuBjopy_nE9A-ph@agluck-desk3>
 <20250601102554.GAaDwqsgCODzEne7Ow@fat_crate.local>
 <aD3ZFyBW4SCyaGI9@agluck-desk3>
 <20250603083157.GAaD6y_fec2X_hTnav@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250603083157.GAaD6y_fec2X_hTnav@fat_crate.local>

On Tue, Jun 03, 2025 at 10:31:57AM +0200, Borislav Petkov wrote:
> On Mon, Jun 02, 2025 at 10:02:15AM -0700, Luck, Tony wrote:
> > This is just an improvement on my "option 1" (improved because all-ones
> > for the component ID is going to be invalid for sure, while all zeroes
> > could be a valid component).
> 
> Right, you need to know at injection time which of the components are valid
> and which are not.
> 
> > Or just stop collecting on the first invalid one.
> 
> That would mean that you punish the user at the first typo. :-P
> 
> Considering how complex those interfaces become perhaps not such a good
> idea...

Here's what EINJ V2 injection looks like to a user (to be included in
Documentation/firmware-guide/acpi/apei/einj.rst):

An EINJv2 error injection example::

  # cd /sys/kernel/debug/apei/einj
  # cat available_error_type                    # See which errors can be injected
  0x00000002    Processor Uncorrectable non-fatal
  0x00000008    Memory Correctable
  0x00000010    Memory Uncorrectable non-fatal
  V2_0x00000001 EINJV2 Processor Error
  V2_0x00000002 EINJV2 Memory Error

  # echo 0x12345000 > param1                    # Set memory address for injection
  # echo 0xfffffffffffff000 > param2            # Range - anywhere in this page
  # echo 0x1 > component_id0                    # First device ID
  # echo 0x4 > component_syndrome0              # First error syndrome
  # echo 0x2 > component_id1                    # Second device ID
  # echo 0x4 > component_syndrome1              # Second error syndrome
  # echo '' > component_id2                     # Mark id2 invalid to terminate list
  # echo V2_0x2 > error_type                    # Choose EINJv2 memory error
  # echo 0xa > flags                            # set flags to indicate EINJv2
  # echo 1 > error_inject                       # Inject now

Note the shorthand to write all-ones using an empty line because
typing:

  # echo fffffffffffffffffffffffffffffff > component_id2

would:
1) give carpal tunnel syndrome
2) wear out the "f" key on my keyboard
3) run the risk of miscounting the number of 'f' characters
   (above is wrong because there are only 31, but hard to spot that).

-Tony

