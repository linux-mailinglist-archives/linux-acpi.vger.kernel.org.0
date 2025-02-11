Return-Path: <linux-acpi+bounces-11031-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8831DA314CB
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 20:15:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E8351884502
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 19:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0117C262D1B;
	Tue, 11 Feb 2025 19:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EdnKsHTz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C238B262D13;
	Tue, 11 Feb 2025 19:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739301289; cv=none; b=bhFl9sbkDxoSxMavs0OCExwnvtOhppjUEuCpivwhEp8IfM5yqex4TcXuTWv6Ak4YMmw4QS0qr/sSiM3Qd8sitP9qrBXVvzQbLLr1xdw9f4zdUIGyNm1xHjfvdTxe+HXg0O45Enqd9kJxAcCybatW8R+0LnyJrK82LwVNEtHoxyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739301289; c=relaxed/simple;
	bh=CuIz18Kc4OMzTX7Xzc1YuhzCxGOGLDt4H5wPO2SiwAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IJZsnN0kGTvttSP2bBD/UVQY6aefRB/lXn+2u5JFaFcK6xuvs10h2FxM8uw4RjSl15xrFRJrCdpxgUa1P3QbGXlnGsVEKSDOcHAzWhbp/r0+tYjXxkZbJROWvWzcwIMtxV2SP7deDcjnkdbmRL92nTlE6x2kKps4wCCWatlOdCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EdnKsHTz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21136C4CEDD;
	Tue, 11 Feb 2025 19:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739301289;
	bh=CuIz18Kc4OMzTX7Xzc1YuhzCxGOGLDt4H5wPO2SiwAk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EdnKsHTzm1ssaC6cv91W9ukkpVsdInstTsFEnoTx+I9UrTd+5EgUGxOK2WR/tErJy
	 qhNzfGO6NUap9JQmm+3b5u6EQO7YYJBlArl//LD10Kg7OVfepluVgn1YyTWCsrkkJp
	 5qTg+aawSRoYrY8/4MpWR2FWxEXCL3vwJBmISinWxBy9d7bOp5l6VBFOhYadIy+Htd
	 nnc1ORve5GmLpSIsKrpfNW3+M7alDc1Zl3cKuSo9VOlRUA3+vCa+1NQggDltuRmXQ8
	 GFVk1XqPfhhvVlwPvjpsh2fyZm5ucx69AK5g0HIH8tgnHNUXY5viS3Knyk8XdaS0xz
	 0vHOgoTnSPfDA==
Date: Tue, 11 Feb 2025 14:14:44 -0500
From: Nathan Chancellor <nathan@kernel.org>
To: Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
	"Limonciello, Mario" <mario.limonciello@amd.com>,
	Kees Cook <kees@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	patches@lists.linux.dev, stable@vger.kernel.org,
	John Rowley <lkml@johnrowley.me>
Subject: Re: [PATCH v3] ACPI: platform-profile: Fix CFI violation when
 accessing sysfs files
Message-ID: <20250211191444.GC2995885@ax162>
References: <20250210-acpi-platform_profile-fix-cfi-violation-v3-1-ed9e9901c33a@kernel.org>
 <52c49252-7a81-4d27-a8a9-b2f1e5f837df@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52c49252-7a81-4d27-a8a9-b2f1e5f837df@app.fastmail.com>

Hi Mark,

On Tue, Feb 11, 2025 at 10:05:18AM -0500, Mark Pearson wrote:
> Just a note to say thank you for noticing my email address change -
> the old lenovo one was awful to use so I dropped it a while back, but
> it meant I missed your first two patches (my mail filters for the list
> should have caught it and I'll have to figure out why not...)

No worries, I totally get that. It may be good to update the few places
in the kernel that still use your Lenovo address but I understand if
there are other reasons to keep it around. .mailmap could also help too.

> Patch looks fine (I'd like to try it out on my system - will aim to do
> that today). I didn't know what CFI was (and have lightly educated
> myself now).  Is there a better way to fix this so it's common across
> all drivers somehow? Updating every individual instance is going to be
> a lot.

This does not happen all too often as far as I can tell. I have only
sent a handful of these patches over the past couple of years since CFI
was officially merged. Due to the way these sysfs interfaces work, I am
not sure this can really be fixed at a grand scale.

Cheers,
Nathan

