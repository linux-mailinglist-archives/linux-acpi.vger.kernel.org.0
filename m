Return-Path: <linux-acpi+bounces-14368-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC724AD9625
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Jun 2025 22:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADEF9165D39
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Jun 2025 20:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D910D23D2A9;
	Fri, 13 Jun 2025 20:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QIGMVxBq"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90C9230BD2;
	Fri, 13 Jun 2025 20:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749846056; cv=none; b=RmhQXEi1TiSdALFv/nx29oFmGeIfeoCPFsymr7Zdz32N3m/n64OLKkUShfDEMbdhxYJomXA5dU1aaKdqdGcPRqkCKIDHdiU2/CuTfGc/oNAvuOvqt5gBSRtCAkkesFfHy6+FQWmOrcpBaGPFnI2Kn/C2uSbElTvBknuo5s503I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749846056; c=relaxed/simple;
	bh=htqwC9HPTDNJN9myqknK132yY5sAyvIs0gpb4UUzsog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=srpU8UiWM2dBjCcqAjmgQPz7LmsAr1JQspeqmkKbJE3OMdC2Rfc1IHd3fkoWGkCte12eGq6bUisndkHg91TJ2DVvLzQfxJ/zf4kurcbWRKILYariYNvcmVx5/JlxGELtLAqQMmvWOTLWPjAkuCQz5IYppJdp7pTKuqF005h4AdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QIGMVxBq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C9E1C4CEE3;
	Fri, 13 Jun 2025 20:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749846056;
	bh=htqwC9HPTDNJN9myqknK132yY5sAyvIs0gpb4UUzsog=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QIGMVxBq5JdG2Q46bdbT7Hv3H9IWel45Ido8smXYCIdn7zlk6F1WFGTRt+KO1cFNO
	 3fZL8lA7YVE18G4wOSvsqBQUtJjlUiIhLxNqN8NtD3a9WXw9VGtixjCfRDx5mcIe3+
	 2qmUDjyPEsAkZboShvLtTeoP3TMQIlpDvF8C7WdqJSilzMWYp8l6/CyTODu4018aXw
	 YeNejFKyrn5nnN7mL2mKLWu/eJJzXrZDHKMICCiXiCirf/hLB323G2oI02ltlrcgcV
	 +8tNBrBaBSYYQug8SKh7dBKfmZX2ZNxjbQQkcLbX4OdyiY0LmaVLknF+EDy65V/fg8
	 rX5G1xa34vI7w==
From: Miguel Ojeda <ojeda@kernel.org>
To: marc.herbert@linux.intel.com
Cc: Benjamin.Cheatham@amd.com,
	Jonathan.Cameron@huawei.com,
	dakr@kernel.org,
	dan.j.williams@intel.com,
	gregkh@linuxfoundation.org,
	linux-acpi@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rafael.j.wysocki@intel.com,
	rafael@kernel.org,
	sudeep.holla@arm.com,
	Kees Cook <kees@kernel.org>
Subject: Re: [PATCH] driver core: faux: fix Undefined Behavior in faux_device_destroy()
Date: Fri, 13 Jun 2025 22:20:27 +0200
Message-ID: <20250613202027.1364272-1-ojeda@kernel.org>
In-Reply-To: <20250613191556.4184103-1-marc.herbert@linux.intel.com>
References: <20250613191556.4184103-1-marc.herbert@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 13 Jun 2025 19:15:56 +0000 marc.herbert@linux.intel.com wrote:
>
> doubts, I include a very short and simple demo below. I imagine kernel
> compilation flags and various other conditions may not make the
> consequences as bad as this example, however those conditions could change

Yeah, the kernel uses `-fno-delete-null-pointer-checks`, so e.g. for your
example:

    https://godbolt.org/z/hs49jb98o

Cheers,
Miguel

