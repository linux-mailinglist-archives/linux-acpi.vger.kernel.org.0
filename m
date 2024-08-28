Return-Path: <linux-acpi+bounces-7947-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B7896347E
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Aug 2024 00:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAC001F24B62
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Aug 2024 22:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2CE1AD401;
	Wed, 28 Aug 2024 22:17:43 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2257E1ABEC4;
	Wed, 28 Aug 2024 22:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724883463; cv=none; b=S7QIDUM/MOYivky0oXWIzf4uE6sCGvTEN460X0+Pvi2YdNFavtz9EvFpJ8GDaez4AdJo3BX6fn+TWmaIAF6Nh00RACOaoapgdkgI8841a4OcgxALHpoiuOYJ+PlU8jPNpvyzJerRbCEw/C2WZAwzMrqCG+v+g+6BZFyZXfAgoqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724883463; c=relaxed/simple;
	bh=xy4g412hpADC8QifL9eJoRK/pCq3SSV4cCSudLV8OEc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Q/Hi8B+UvC3gsmPOjlwBBo6L7G6IaiDM38aOoWWdEqyJe2B6hYaJBILJ3LYKkAPQDih7Zx54hGz5snM0DH36oLTOm/GjPiqfSi52F+YMKoz0s9mMtKWuIOE3WCFTwV/4TiBSdWKGLeKqtIBeOUgEXTJOiuGKYqA5HBEgTgA9+YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A929BC4CEC6;
	Wed, 28 Aug 2024 22:17:42 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 480781060533; Thu, 29 Aug 2024 00:17:40 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, 
 Asmaa Mnebhi <asmaa@nvidia.com>
Cc: David Thompson <davthompson@nvidia.com>
In-Reply-To: <20240611134327.30975-1-asmaa@nvidia.com>
References: <20240611134327.30975-1-asmaa@nvidia.com>
Subject: Re: [PATCH v2 1/1] power: reset: pwr-mlxbf: support graceful
 shutdown
Message-Id: <172488346028.466860.15092209246524178878.b4-ty@collabora.com>
Date: Thu, 29 Aug 2024 00:17:40 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1


On Tue, 11 Jun 2024 09:43:27 -0400, Asmaa Mnebhi wrote:
> The OCP board used a BlueField's GPIO pin for entering
> low power mode. That board was not commercialized and
> has been dropped from production so all its code is unused.
> The new hardware requirement is to trigger a graceful shutdown
> when that GPIO pin is toggled. So replace the unused low power
> mode with a graceful shutdown.
> 
> [...]

Applied, thanks!

[1/1] power: reset: pwr-mlxbf: support graceful shutdown
      commit: 292fe42c34a9e9eea07f58a691813e077e9ca86f

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


