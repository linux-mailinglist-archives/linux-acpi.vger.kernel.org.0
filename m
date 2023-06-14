Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8711A7305E8
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jun 2023 19:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237892AbjFNRTP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 14 Jun 2023 13:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238536AbjFNRSr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Jun 2023 13:18:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FBCB271C;
        Wed, 14 Jun 2023 10:18:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D817D644E1;
        Wed, 14 Jun 2023 17:18:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51F5FC43397;
        Wed, 14 Jun 2023 17:18:36 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Jose Marinho <jose.marinho@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Jeremy Linton <Jeremy.Linton@arm.com>,
        James Morse <James.Morse@arm.com>,
        Rob Herring <Rob.Herring@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Hanjun Guo <guohanjun@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH 0/3 v2] Update ACPI documentation for Arm systems
Date:   Wed, 14 Jun 2023 18:18:33 +0100
Message-Id: <168676310795.1665526.7555742105966287304.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230606093528.1494344-1-jose.marinho@arm.com>
References: <20230606093528.1494344-1-jose.marinho@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, 06 Jun 2023 10:35:25 +0100, Jose Marinho wrote:
> This set of patches updates the Linux kernel ACPI documentation for Arm
> systems. The intent is to integrate the developments in the BBR
> specification that happened over the last couple of years.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Jeremy Linton <Jeremy.Linton@arm.com>
> Cc: James Morse <James.Morse@arm.com>
> Cc: Rob Herring <Rob.Herring@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Hanjun Guo <guohanjun@huawei.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-doc@vger.kernel.org
> Cc: linux-acpi@vger.kernel.org
> 
> [...]

Applied to arm64 (for-next/acpi-doc), thanks!

[1/3] Documentation/arm64: Update ARM and arch reference
      https://git.kernel.org/arm64/c/137477c8daac
[2/3] Documentation/arm64: Update references in arm-acpi
      https://git.kernel.org/arm64/c/8c350dfc9065
[3/3] Documentation/arm64: Update ACPI tables from BBR
      https://git.kernel.org/arm64/c/3927eaff464f

-- 
Catalin

