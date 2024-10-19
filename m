Return-Path: <linux-acpi+bounces-8863-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7239A4CC2
	for <lists+linux-acpi@lfdr.de>; Sat, 19 Oct 2024 12:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D1ED283BEB
	for <lists+linux-acpi@lfdr.de>; Sat, 19 Oct 2024 10:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164D11DE4D7;
	Sat, 19 Oct 2024 10:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="kPTKEW/J"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE11218755C
	for <linux-acpi@vger.kernel.org>; Sat, 19 Oct 2024 10:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729332663; cv=none; b=c30BRTw3XJcfuKdhdGi8HlT5kSKYJ+TYJCgD4nOeUdvX91ahHwFvuX46hMArD/fS5IcsMPhmGrlnypxqd2rO/L/yPKWxCFXhB7sp8m0bmUkiC2zZl+RYRPldjOcrs+HTGLaWen679S+FAiHNsDpBvDZoDyeTpyp7Z69Wqpd/f4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729332663; c=relaxed/simple;
	bh=/td8KXFB8ZEPLMkzBnVn6jDcQbcOrM1Dm3yC1PxCGCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OeX6BrI8/xfpnMWuLWOhuLjOpTIp3C6lsaHnmMMiLPpYm3Kjl55Gl0P7deOUpHbQvLstGoEYdtH7ICe13pJRHRQUhHZnDbxr6w1Nu+6uca/DQwO2yI03O3EzhR859H78vVQqZCtTmbDlK9GfDzBYkFayOJQz+zmgNI3H1t+PGh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=kPTKEW/J; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8C0BB40E021A;
	Sat, 19 Oct 2024 10:10:58 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 9rLzuIogIG8S; Sat, 19 Oct 2024 10:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1729332654; bh=t+W8//qAzYYxTA+VNR5f7rTIpzbUXkarAqobpn2MCW4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kPTKEW/J0VWJ5QRYkwlsntArO6eG7wPC/B3yHsXvBDgT+yPeejpRuAEUSBK06MYK/
	 8azStk9Kkw4lr2yL4cVpk/rUVlWFkqbrd7iYiFGxqPb8HFH0JiDTBvOzdI/Je5FaGa
	 ARuCv3aFrqd/t95Po58BLfBec+DSL+teDqAt49hHJCXhtrJdsDP7PQiSJWKdBQAEfN
	 vKroWWWOgSpqtGhaspWuuapDt7POQXmvg+Fecg/+XM/atfpgV4q/xDYPQnvT8IsNqt
	 Oe0Bmjkl0/DAfHSmOufIIZj/rFmi8MAwsui0ny3dp3ucVpny1f4K7AelqnrryLSEAM
	 vM4URO+N4WgKutls4gvy4mpXTZGqZ2V8tEYxEaFgVpFa0Fc0mHCEYHE1c6W1gFigoP
	 wzWd2enaAOW84WxD92ttx7mA+/vIoPCAySAalL7nNfsuo0118+EzyQ3STQKyh93BP8
	 ojb8c7gj9WekKXOh4P/PZXHF+WbCaI0aHX0LyNQWTqsL/tVYBxCFxIaOUqMhlSYI7P
	 SP5DIwyMq3tp5VryGjmCcHPG8dPnxN7rZLiLPLVI4sfmC5mjPTqDA3tW+s1E4Kw8gY
	 Per56GDNo4J5j+fUcMgaGDK3vj7q3iSr2xN9l+IJi04l+kChgbjnr+u2dXwUKlk5D0
	 FCfoq5uKNvMd8+Qq4UgDpiEs=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6C2FC40E0163;
	Sat, 19 Oct 2024 10:10:47 +0000 (UTC)
Date: Sat, 19 Oct 2024 12:10:42 +0200
From: Borislav Petkov <bp@alien8.de>
To: Mario Limonciello <superm1@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: x86@kernel.org, linux-acpi@vger.kernel.org,
	Perry Yuan <perry.yuan@amd.com>, gautham.shenoy@amd.com,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH 1/2] x86/cpufeatures: Add feature bits for AMD
 heterogeneous processor
Message-ID: <20241019101042.GCZxOFooaiQPq-Q-2p@fat_crate.local>
References: <20241003213759.3038862-1-superm1@kernel.org>
 <20241003213759.3038862-2-superm1@kernel.org>
 <20241018182440.GDZxKn6FkYji_9Xhau@fat_crate.local>
 <6271aaed-fb4c-4101-82a2-e18aba05b4d4@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6271aaed-fb4c-4101-82a2-e18aba05b4d4@kernel.org>

On Fri, Oct 18, 2024 at 01:31:51PM -0500, Mario Limonciello wrote:
> 2) Rafael can drop this and the follow on and I'll resubmit with your
> feedback and we can bring through tip
> 
> 3) I can amend with the fixes we take through linux-pm/linux-next to avoid
> the acrobatics of 1 or 2.

Since I don't see any conflicts with tip yet and you have other stuff which is
cross-tree, I could review the tip bits and then Rafael can pick them all up
and route them through the pm tree.

Alternatively, I can route the tip bits through the tip tree and I can give
Rafael an immutable tip branch he can merge and then rebase the remaining pm
changes ontop.

Rafael?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

