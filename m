Return-Path: <linux-acpi+bounces-13389-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD81AA53C7
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Apr 2025 20:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D11B9C7691
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Apr 2025 18:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346B025D1FC;
	Wed, 30 Apr 2025 18:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L6VexaoL"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B28D18024;
	Wed, 30 Apr 2025 18:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746038126; cv=none; b=E/b5fTfsE9zva4d/VJ88/DdQeaI+m+rqu6PXVQZSGJ1B+KUP7zghj5s5eyfNUMBYrfJRciX0T88349gLOF1KVtx0vHRPQaObbXCZXTsk0zE8KPSKT62D0SUMI4gQQz6Wy8IaLThRWUei873BT6ynfoBD4NhMkp7gh3/3Q+R2Rnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746038126; c=relaxed/simple;
	bh=MYqpFKUaSIk71XNr25v/CZ6EuiBJHRRvSuY0BW160aY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FG0eVPUFoVnUl22KiXz7kqIAf/LrD6HVuIBZv34aaU6KqObXZZspAOgaMruIFBAslrgY/1piJgErOrONLtcOJpr27wA3GTNXSCDhaKDqJpkTKfpTGgWPpcNZ/VidYT5bvtTfUaHhjXmLHQgzePG3Gp2N7j6e9aW5bHDg+/LMPiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L6VexaoL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75726C4CEE7;
	Wed, 30 Apr 2025 18:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746038125;
	bh=MYqpFKUaSIk71XNr25v/CZ6EuiBJHRRvSuY0BW160aY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L6VexaoLuiuSk/yv6kmgycQgRjNg1zbS4nifn9yD6G34FkfBre/hOWBdOXzJRK4bd
	 m+cIy81zf6EBAepby1zixvMvFHdPV5ipzUXUB3ATxNhTJ73FmA20/4g428YyM3e8hP
	 PTpX1VJf6fpGVIKcjy+pwQGXCXQGHM69rEfDwu9Z1ixdIvTUzJ6ilwgZQVgoHAmMP9
	 ZM6huujvlxE8NfnmHX+dqmtnofP+4jhDpdNLMk8GFEIDnPg0H4T/PTHEpHuOI2rWxb
	 H8tIweqftC7MIss6rYS92SA8bRo5BR3z3QmuLkXpzXFpeW2vz/v0AUNxWz6CqaX+dc
	 U29wLI+g1kfjQ==
Date: Wed, 30 Apr 2025 11:35:22 -0700
From: Kees Cook <kees@kernel.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Bob Moore <robert.moore@intel.com>,
	Saket Dumbre <saket.dumbre@intel.com>
Subject: Re: [PATCH v1 12/19] ACPICA: Introduce ACPI_NONSTRING
Message-ID: <202504301134.2EF987A@keescook>
References: <12671029.O9o76ZdvQC@rjwysocki.net>
 <1841930.VLH7GnMWUR@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1841930.VLH7GnMWUR@rjwysocki.net>

On Fri, Apr 25, 2025 at 09:27:58PM +0200, Rafael J. Wysocki wrote:
> From: Kees Cook <kees@kernel.org>
> 
> ACPICA commit 878823ca20f1987cba0c9d4c1056be0d117ea4fe
> 
> In order to distinguish character arrays from C Strings (i.e. strings with
> a terminating NUL character), add support for the "nonstring" attribute
> provided by GCC. (A better name might be "ACPI_NONCSTRING", but that's
> the attribute name, so stick to the existing naming convention.)
> 
> GCC 15's -Wunterminated-string-initialization will warn about truncation
> of the NUL byte for string initializers unless the destination is marked
> with "nonstring". Prepare for applying this attribute to the project.
> 
> Link: https://github.com/acpica/acpica/commit/878823ca
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Whoops, I missed adding my S-o-b to the original upstream ACPICA commit.
Please consider this:

Signed-off-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

