Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1C434AF9E5
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Feb 2022 19:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238440AbiBISYQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 9 Feb 2022 13:24:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231371AbiBISYJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Feb 2022 13:24:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76FAAC05CB82
        for <linux-acpi@vger.kernel.org>; Wed,  9 Feb 2022 10:24:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1E0F1B82380
        for <linux-acpi@vger.kernel.org>; Wed,  9 Feb 2022 18:24:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03B31C340E7;
        Wed,  9 Feb 2022 18:24:07 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Robin Murphy <robin.murphy@arm.com>, guohanjun@huawei.com,
        sudeep.holla@arm.com, lorenzo.pieralisi@arm.com
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH v2] ACPI/IORT: Check node revision for PMCG resources
Date:   Wed,  9 Feb 2022 18:24:05 +0000
Message-Id: <164443102845.196616.8228457095383066529.b4-ty@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <75628ae41c257fb73588f7bf1c4459160e04be2b.1643916258.git.robin.murphy@arm.com>
References: <75628ae41c257fb73588f7bf1c4459160e04be2b.1643916258.git.robin.murphy@arm.com>
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

On Thu, 3 Feb 2022 19:31:24 +0000, Robin Murphy wrote:
> The original version of the IORT PMCG definition had an oversight
> wherein there was no way to describe the second register page for an
> implementation using the recommended RELOC_CTRS feature. Although the
> spec was fixed, and the final patches merged to ACPICA and Linux written
> against the new version, it seems that some old firmware based on the
> original revision has survived and turned up in the wild.
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] ACPI/IORT: Check node revision for PMCG resources
      https://git.kernel.org/arm64/c/da5fb9e1ad3f

(also added a cc stable)

-- 
Catalin

