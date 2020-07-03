Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84178214081
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Jul 2020 22:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbgGCUvf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 3 Jul 2020 16:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbgGCUvc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 3 Jul 2020 16:51:32 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3226CC061794;
        Fri,  3 Jul 2020 13:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Tl3H8CzGCLvArKNIHynag6Y7Rh0ZqBjl93cSC6admS4=; b=MPYd72ZG+tlel/BPwlAFQj3Cjy
        il1UDH9nms8sY2hb0kzzbeovX/Rbnhyrm/UNnq0t+RtV6ZTjigfU+TfsjyGZX3jKJvdTbmfxwJcZf
        NkR8yN/vtNot8TSASfxzEC04BsMmgast8e+BFAZat5rzUmzZfv23Gpv6k2gY7xsm1C1gvm7XzLktd
        XbvewtwmXYsx8cNrAMNhY0S9+a2qvysOmc3G34tnr00N7C32NXt3mx3zH67CHK4HTNPWAsAy8rKg1
        k545v0mpS6yz9PCHQyVHTiLAh5B74f+/zPEXpFVs3+++bgwsdDyeA8DhW43qMBYjBdAJeJ18t1sLQ
        u0n/ZnAA==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrSef-0001yn-Gd; Fri, 03 Jul 2020 20:51:30 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dave Martin <Dave.Martin@arm.com>
Subject: [PATCH 3/3] Documentation: arm64/sve: drop duplicate words
Date:   Fri,  3 Jul 2020 13:51:10 -0700
Message-Id: <20200703205110.29873-4-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200703205110.29873-1-rdunlap@infradead.org>
References: <20200703205110.29873-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Drop the doubled word "for".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: Dave Martin <Dave.Martin@arm.com>
---
 Documentation/arm64/sve.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200701.orig/Documentation/arm64/sve.rst
+++ linux-next-20200701/Documentation/arm64/sve.rst
@@ -494,7 +494,7 @@ Appendix B.  ARMv8-A FP/SIMD programmer'
 Note: This section is for information only and not intended to be complete or
 to replace any architectural specification.
 
-Refer to [4] for for more information.
+Refer to [4] for more information.
 
 ARMv8-A defines the following floating-point / SIMD register state:
 
