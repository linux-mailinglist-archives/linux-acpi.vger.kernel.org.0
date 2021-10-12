Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05A7842A9D6
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Oct 2021 18:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbhJLQqQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 12 Oct 2021 12:46:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:43572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229495AbhJLQqQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 12 Oct 2021 12:46:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 263EB60F21;
        Tue, 12 Oct 2021 16:44:13 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     guohanjun@huawei.com, Jackie Liu <liu.yun@linux.dev>,
        lorenzo.pieralisi@arm.com
Cc:     Will Deacon <will@kernel.org>, liuyun01@kylinos.cn,
        linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] acpi/arm64: fix next_platform_timer() section mismatch error
Date:   Tue, 12 Oct 2021 17:44:11 +0100
Message-Id: <163405697347.426151.4032663664664574820.b4-ty@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210823092526.2407526-1-liu.yun@linux.dev>
References: <20210823092526.2407526-1-liu.yun@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, 23 Aug 2021 17:25:26 +0800, Jackie Liu wrote:
> Fix modpost Section mismatch error in next_platform_timer().
> 
>   [...]
>   WARNING: modpost: vmlinux.o(.text.unlikely+0x26e60): Section mismatch in reference from the function next_platform_timer() to the variable .init.data:acpi_gtdt_desc
>   The function next_platform_timer() references
>   the variable __initdata acpi_gtdt_desc.
>   This is often because next_platform_timer lacks a __initdata
>   annotation or the annotation of acpi_gtdt_desc is wrong.
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] acpi/arm64: fix next_platform_timer() section mismatch error
      https://git.kernel.org/arm64/c/596143e3aec3

-- 
Catalin

