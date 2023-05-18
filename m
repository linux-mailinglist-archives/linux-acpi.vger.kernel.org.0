Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 282AB707E87
	for <lists+linux-acpi@lfdr.de>; Thu, 18 May 2023 12:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbjERKxq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 18 May 2023 06:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjERKxn (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 18 May 2023 06:53:43 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EE9EAE66;
        Thu, 18 May 2023 03:53:40 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47A791FB;
        Thu, 18 May 2023 03:54:25 -0700 (PDT)
Received: from josmar02Desktop.cambridge.arm.com (josmar02Desktop.cambridge.arm.com [10.2.78.53])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1CE8B3F793;
        Thu, 18 May 2023 03:53:39 -0700 (PDT)
From:   Jose Marinho <jose.marinho@arm.com>
Cc:     Jose Marinho <jose.marinho@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jeremy Linton <Jeremy.Linton@arm.com>,
        James Morse <James.Morse@arm.com>,
        Rob Herring <Rob.Herring@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH 0/3] Update ACPI documentation for Arm systems
Date:   Thu, 18 May 2023 11:51:59 +0100
Message-Id: <20230518105202.451739-1-jose.marinho@arm.com>
X-Mailer: git-send-email 2.40.0.141.g8d90352acc
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This set of patches updates the Linux kernel ACPI documentation for Arm
systems. The intent is to integrate the developments in the BBR
specification that happened over the last couple of years.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Jeremy Linton <Jeremy.Linton@arm.com>
Cc: James Morse <James.Morse@arm.com>
Cc: Rob Herring <Rob.Herring@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-doc@vger.kernel.org
Cc: linux-acpi@vger.kernel.org

Jose Marinho (3):
  Documentation/arm64: Update ARM and arch reference
  Documentation/arm64: Update references in arm-acpi
  Documentation/arm64: Update ACPI tables from BBR

 Documentation/arm64/acpi_object_usage.rst |  81 ++++++++++-
 Documentation/arm64/arm-acpi.rst          | 168 ++++++++++++++--------
 2 files changed, 183 insertions(+), 66 deletions(-)

-- 
2.40.0.141.g8d90352acc

