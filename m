Return-Path: <linux-acpi+bounces-1550-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4AC7ED99A
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Nov 2023 03:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2915B1C2090B
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Nov 2023 02:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD3C8F56
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Nov 2023 02:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C9F7E
	for <linux-acpi@vger.kernel.org>; Thu, 16 Nov 2023 00:38:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 448A4C433C7;
	Thu, 16 Nov 2023 00:38:45 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 071641062B52; Thu, 16 Nov 2023 01:38:42 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, 
 Asmaa Mnebhi <asmaa@nvidia.com>
In-Reply-To: <20231030203058.8056-1-asmaa@nvidia.com>
References: <20231030203058.8056-1-asmaa@nvidia.com>
Subject: Re: [PATCH v1 1/1] power: reset: pwr-mlxbf: support graceful
 reboot instead of emergency reset
Message-Id: <170009512199.785165.15508429690118888227.b4-ty@collabora.com>
Date: Thu, 16 Nov 2023 01:38:41 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Mon, 30 Oct 2023 16:30:58 -0400, Asmaa Mnebhi wrote:
> Replace the soft reset with a graceful reboot.
> An acpi event will be triggered by the irq in the pwr-mlxbf.c
> to trigger the graceful reboot.
> 
> 

Applied, thanks!

[1/1] power: reset: pwr-mlxbf: support graceful reboot instead of emergency reset
      commit: b9afaa069e58939d95923c27c2fd76a0523119a7

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


