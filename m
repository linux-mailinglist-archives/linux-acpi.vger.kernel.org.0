Return-Path: <linux-acpi+bounces-21476-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPWcAzVcqmmkQAEAu9opvQ
	(envelope-from <linux-acpi+bounces-21476-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Mar 2026 05:46:45 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9736321B827
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Mar 2026 05:46:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5E7A13028E90
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Mar 2026 04:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F4035274B58;
	Fri,  6 Mar 2026 04:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nv9bdOZL"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE42F21CC7B;
	Fri,  6 Mar 2026 04:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772772399; cv=none; b=ZRhChClm+MoPhicqMDTUA8WZZNJ9jLy8TkGvMAn5LZpxmiWRKSAqaNcoG/3Acq9/zWnRYCs0f6A9PIjA2gy9D85dEj/x7tgjjRVyIaNko78h5CqjHNdTrbysNtFdEWfq2y27TSwb5DU5m0x+og9nluaoyi9J31+0ZYmfpGRkwPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772772399; c=relaxed/simple;
	bh=f79BlgSg2in5KMGVfAJr8z5EZZmUtj9u7hprpV0hlH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hPO1xKLwFifR0GQb+g7MFVQ1efL+nxgwOBla19jypzgNH41PC7Dipd14lqhjFDWl/HXDcS4kdc6H6bfk+nBdGzK5O6b8gICKpzN/hJWyyLEsppiQvtZG8hTNtJxSWlG/cz5UtF0MR54CI059SrSjPebdkG26/A+f1Fnp2lncurM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nv9bdOZL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53D74C19422;
	Fri,  6 Mar 2026 04:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772772399;
	bh=f79BlgSg2in5KMGVfAJr8z5EZZmUtj9u7hprpV0hlH8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nv9bdOZLpVjJtVcYH4YKiEvY3dV9ExZsQN2de7AxOW2GHBJ6zwdKX30ZKsleR9gEz
	 ZeGbHv+AoVy3wZ3gZzq9pUl0JSgFR1RCT4BLLOApv8arvwIDq48AbhyVAtSYmlQKYg
	 wtPnK+TL4IxzjMISiKtQagsvKlkRTZH3d5xWLljTXS+CY9+70KdaktUAVp8+ZM6g5w
	 HQEWrAb1Qw+Yf06V+7B3gMBGY9x61npLZLpMfokxGZwyao++pac/iTBQlkJn0BQ0Dz
	 btyAJfPpYikc/CaT7+mRrISlCwqwfqJY7DLOAOcBDJf52cRDmAS9Jz3Y/uji2cfE9o
	 EqfFaBhtEGkxQ==
Date: Fri, 6 Mar 2026 04:46:36 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: chrome-platform@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
	Linux ACPI <linux-acpi@vger.kernel.org>,
	Benson Leung <bleung@chromium.org>,
	Enric Balletbo i Serra <eballetbo@kernel.org>,
	Ravi Chandra Sadineni <ravisadineni@chromium.org>
Subject: Re: [PATCH v2 0/6] platform/chrome: Bind drivers to platform devices
 instead of ACPI ones
Message-ID: <aapcLMIq-hk_Ze_Y@google.com>
References: <6259948.lOV4Wx5bFT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6259948.lOV4Wx5bFT@rafael.j.wysocki>
X-Rspamd-Queue-Id: 9736321B827
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-21476-lists,linux-acpi=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tzungbi@kernel.org,linux-acpi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Thu, Mar 05, 2026 at 08:34:58PM +0100, Rafael J. Wysocki wrote:
> Hi All,
> 
> This is a v2 of
> 
> https://lore.kernel.org/linux-acpi/2274474.Mh6RI2rZIc@rafael.j.wysocki/
> 
> addressing review comments on patches [2/6] and [4/6].
> 
> The series description below still applies.
>
> [...]

Applied to

    https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git for-next

[1/6] platform/chrome: Convert ChromeOS privacy-screen driver to platform
      commit: d3c2872ae323ea45cc32ea0247f26c2189a481cb
[2/6] platform/chrome: chromeos_tbmc: Drop wakeup source on remove
      commit: 5d441a4bc93642ed6f41da87327a39946b4e1455
[3/6] platform/chrome: chromeos_tbmc: Register ACPI notify handler
      commit: de1260139dbd7610a2f25343c962569b8fe23f8f
[4/6] platform/chrome: chromeos_tbmc: Convert to a platform driver
      commit: a2676ead257f6cf12e458efc786a68d6ab7c1224
[5/6] platform/chrome: wilco_ec: event: Register ACPI notify handler
      commit: 25a06b7a3224161cf4b27049bea93cac21136460
[6/6] platform/chrome: wilco_ec: event: Convert to a platform driver
      commit: 27d58498f690ab39140678df918155a597b3a17a

Thanks!

