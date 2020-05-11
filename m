Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5215F1CE066
	for <lists+linux-acpi@lfdr.de>; Mon, 11 May 2020 18:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730692AbgEKQ2D (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 11 May 2020 12:28:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:38448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730658AbgEKQ2D (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 11 May 2020 12:28:03 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19B3820720;
        Mon, 11 May 2020 16:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589214482;
        bh=nHP8K2loP8fNNvk39GdbJPey1+kZMKWKWEytPBaMcxw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=II0LDklD9XYd65fHxKxk8cPX0NaKftxcMowEHXOhR+YHTc3LiNUAj4CmnfUEtmNr9
         AaBwsVID1DVdzvatpFNKKDxIO9sza2Pr/k1FTUgq618LtwI7dUhGp4IYICSNkw6gtg
         jPPmEwQcc4waLwIlBK9kqm7Pcg6etOjgV3+U0MWI=
From:   Will Deacon <will@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Hanjun Guo <guohanjun@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     catalin.marinas@arm.com, Will Deacon <will@kernel.org>,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] ACPI: IORT: Add extra message "applying workaround" for off-by-1 issue
Date:   Mon, 11 May 2020 17:27:55 +0100
Message-Id: <158920943595.105559.13805168263649265884.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1588910198-8348-1-git-send-email-guohanjun@huawei.com>
References: <1588910198-8348-1-git-send-email-guohanjun@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, 8 May 2020 11:56:38 +0800, Hanjun Guo wrote:
> As we already applied a workaround for the off-by-1 issue,
> it's good to add extra message "applying workaround" to make
> people less uneasy to see FW_BUG message in the boot log.

Applied to arm64 (for-next/acpi), thanks!

[1/1] ACPI: IORT: Add extra message "applying workaround" for off-by-1 issue
      https://git.kernel.org/arm64/c/44cdc7b16e0a

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
