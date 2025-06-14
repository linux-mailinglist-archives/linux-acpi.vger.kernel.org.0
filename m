Return-Path: <linux-acpi+bounces-14374-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88BAFAD9C39
	for <lists+linux-acpi@lfdr.de>; Sat, 14 Jun 2025 12:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7B773BB90E
	for <lists+linux-acpi@lfdr.de>; Sat, 14 Jun 2025 10:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85BD1E1A33;
	Sat, 14 Jun 2025 10:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W7HMw0/H"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C6E19F480;
	Sat, 14 Jun 2025 10:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749898267; cv=none; b=eIL15bMrfFrBEP3g6DILZiAxCcMj/ew+46jLZSMA/y2br7H8ypouJQvMq5VYJnFJtBH7PcUatYheazkEvgNUGL0Kktq27ZC8BH+weAwU5Aut4sKrqvhcl/lkRsOwlgZexlBqZh3WJmK1i1jlDWeFo9UxvwtuNXB40um4z1nd6uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749898267; c=relaxed/simple;
	bh=+QjFaIiMUGSJzqiOOXTmYspLVyzPEZz6q9ARTn/uewc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qwr09yz4mZre/g1PS5+QRNbtE9VhnkL0KEY9g/iOvhutz2smdPc3RW8JXoxxJ+U5b1uIxw5+wqBNRIIBcYKaxKdvYWncT+A7K1V7jqj3GOTJxAow5V3/I5+9bI1xl2v0hm2bT2r4m3Y8wxxX1Jhbmvcs7NDq4TamPqDui3tbIac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W7HMw0/H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C9C2C4CEEB;
	Sat, 14 Jun 2025 10:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749898267;
	bh=+QjFaIiMUGSJzqiOOXTmYspLVyzPEZz6q9ARTn/uewc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W7HMw0/HiO88n418s+oUcT09ImF2TblWw6gUPyYskfxNN8VzSlKPJq5dvSdp5B2Jq
	 8m7GCWE+j38hvFxW7O/diRK2Lb4LpKGZxJ1VL+dLhO2jBKiZBH8t67zykFQIaQOwxu
	 lYyu/Aih3Qyb0Yi/wE7KmlhZ7rBI/PsAXlMQIofi34XxKGyMfHe8fz56x+8YsvRkKj
	 3Tz3jYrJmDS++jrkwr9yxPVT0lArlDvnjh/ZrBt06ECALnlu5FDST7RZ4l3H7+eAVG
	 /r0p8rM1o45Vj/5KvcbnHETYicrDYxPHqIDeSGYBY4LeeUoiFyreCttAMb/SBgFuGJ
	 rThaM54GH8sgg==
From: Miguel Ojeda <ojeda@kernel.org>
To: gregkh@linuxfoundation.org
Cc: Benjamin.Cheatham@amd.com,
	Jonathan.Cameron@huawei.com,
	dakr@kernel.org,
	dan.j.williams@intel.com,
	linux-acpi@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	marc.herbert@linux.intel.com,
	rafael.j.wysocki@intel.com,
	rafael@kernel.org,
	sudeep.holla@arm.com,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Kees Cook <kees@kernel.org>
Subject: Re: [PATCH] driver core: faux: fix Undefined Behavior in faux_device_destroy()
Date: Sat, 14 Jun 2025 12:50:37 +0200
Message-ID: <20250614105037.1441029-1-ojeda@kernel.org>
In-Reply-To: <2025061313-theater-surrender-944c@gregkh>
References: <2025061313-theater-surrender-944c@gregkh>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 13 Jun 2025 20:33:42 -0400 Greg KH <gregkh@linuxfoundation.org> wrote:
>
> Great writeup, but as Miguel says, this isn't needed at all, the kernel
> relies on the compiler to be sane :)

We may still want to clean them up, e.g. for tooling -- Kees/Dan: do we?
e.g. I see a similar case with discussion at:

    https://lore.kernel.org/lkml/3f1e7aaa-501a-44f1-8122-28e9efa0a33c@web.de/

Which in the end was picked up as commit 2df2c0caaecf ("fbdev: au1100fb:
Move a variable assignment behind a null pointer check").

Cheers,
Miguel

