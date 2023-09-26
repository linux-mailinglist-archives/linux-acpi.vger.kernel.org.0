Return-Path: <linux-acpi+bounces-163-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C88517AF53A
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Sep 2023 22:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 809EA283638
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Sep 2023 20:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6916E4A53F
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Sep 2023 20:32:43 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A85F36B1E
	for <linux-acpi@vger.kernel.org>; Tue, 26 Sep 2023 20:22:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CCE6C433C8;
	Tue, 26 Sep 2023 20:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695759771;
	bh=PUCS5Lkx4xnsCp+42xen5rc6oadHmzi8Dj3sAEHCGvw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=n7ENiYnwXnc5BZrvL8tm4j51B65KhsrEmdvCPEHRIUEJQrqrEqw2fNJNbN9QopzyM
	 E9yo9sUNu3c+Z4u7v6yErZjVr297bgY3LbL34Vsr557S8ldDM2ESqgsNcaZciQILdP
	 d9g+sk1xu5FBY+/doR/+cKcMxbq9IVhRYddYi0Hxh3BVzpKj76al52jrV2Sz4SXBe+
	 a0MJY6+01Ry95jSSas+bCXyfw632sRqyLMmQeF8u70wEgw8KS7sW2ACItkQc8yDo2D
	 6lL5sUa2VF/wX5ScH3W/cLxWvLx8HKGrp+ZgLAy6ooks3k6qpBV7grKqR3z62mL4Il
	 XCvPyvBNdHwmw==
Date: Tue, 26 Sep 2023 15:22:49 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ben Cheatham <Benjamin.Cheatham@amd.com>
Cc: rafael@kernel.org, dan.j.williams@intel.com, linux-cxl@vger.kernel.org,
	linux-acpi@vger.kernel.org, bhelgaas@google.com,
	yazen.ghannam@amd.com
Subject: Re: [PATCH v5 2/3] ACPI, APEI, EINJ: Add CXL 1.1 EINJ error type
 support
Message-ID: <20230926202249.GA425563@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925200127.504256-3-Benjamin.Cheatham@amd.com>

On Mon, Sep 25, 2023 at 03:01:26PM -0500, Ben Cheatham wrote:
> Add support for CXL EINJ error types for CXL 1.1 hosts added in ACPI
> v6.5. Because these error types target memory-mapped CXL 1.1 compliant
> downstream ports and not physical (normal/persistent) memory, these
> error types are not currently  allowed through the memory range
> validation done by the EINJ driver.
> 
> The MMIO address of a CXL 1.1 downstream port can be found in the
> cxl_rcrb_addr file in the corresponding dport directory under
> /sys/bus/cxl/devices/portX. CXL 1.1 error types follow the same
> procedure as a memory error type, but with param1 set to the
> downstream port MMIO address.
> 
> Example usage:
> $ cd /sys/kernel/debug/apei/einj
> $ cat available_error_type
>     0x00000008      Memory Correctable
>     0x00000010      Memory Uncorrectable non-fatal
>     0x00000020      Memory Uncorrectable fatal
>     0x00000040      PCI Express Correctable
>     0x00000080      PCI Express Uncorrectable non-fatal
>     0x00000100      PCI Express Uncorrectable fatal
>     0x00008000      CXL.mem Protocol Correctable
>     0x00020000      CXL.mem Protocol Uncorrectable fatal
> $ echo 0x8000 > error_type
> $ echo 0xfffffffffffff000 > param2
> $ echo 0x2 > flags
> $ cat /sys/bus/cxl/devices/portX/dportY/cxl_rcrb_addr
> 0xb2f00000
> $ echo 0xb2f00000 > param1

It seems sort of unpleasant to expose the physical base address of the
RCRB.  Is there any way to use a device address or other logical
identifier instead and keep the actual MMIO address internal?  E.g., a
PCI device has a <domain>:<bus>:<device>.<function> address.  I assume
CXL addresses would look similar?

> $ echo 1 > error_inject
> ...

> +static int is_valid_cxl_addr(u64 addr)

Maybe the function name should include a hint that this should be an
RCRB address?  But I don't claim to know the CXL architecture or
nomenclature.

Bjorn

