Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4581121407C
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Jul 2020 22:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbgGCUvb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 3 Jul 2020 16:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbgGCUva (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 3 Jul 2020 16:51:30 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 025D7C061794;
        Fri,  3 Jul 2020 13:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=HQLQMgzYkfjithKRdyb5j6fFunP1pdhTzly7cLus8gc=; b=nFlYU0u4fSXmbMIEf55TWlwhha
        dk5qMoQZrPK2b27tbiusFolXKDOYDqVtJn0OVHEa7ZcTvMFxCCa41M/HQuJu0JzMMBzuxUgo6RxpB
        dxgF0b8LoubLRUeSM9FGYtyF+tvZIqUv3MWjY1H6TRx9G7/SPvtONb0ecBQL+9AXjpC0EPUuozQ8r
        M3Jk33tfhz8hA6viNVH9ZsLT26d5NpONB9I01O9KmduNCJhCe/4ySBXwWhkKEmCccjJVo0vFvtJMt
        ExYO4hWMlSgZMTIgSnRmmHJGPv4dCfMWy0ZASuzudFzCK6rCHetEcsadiSXmJgmbVSox11tA/BxbA
        TlAgBnZg==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrSeb-0001yn-Ge; Fri, 03 Jul 2020 20:51:26 +0000
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
Subject: [PATCH 2/3] Documentation: arm64/acpi_object_usage: drop duplicate words
Date:   Fri,  3 Jul 2020 13:51:09 -0700
Message-Id: <20200703205110.29873-3-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200703205110.29873-1-rdunlap@infradead.org>
References: <20200703205110.29873-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Drop the doubled word "and".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Hanjun Guo <guohanjun@huawei.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-acpi@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
---
 Documentation/arm64/acpi_object_usage.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200701.orig/Documentation/arm64/acpi_object_usage.rst
+++ linux-next-20200701/Documentation/arm64/acpi_object_usage.rst
@@ -220,7 +220,7 @@ LPIT   Signature Reserved (signature ==
        x86 only table as of ACPI 5.1; starting with ACPI 6.0, processor
        descriptions and power states on ARM platforms should use the DSDT
        and define processor container devices (_HID ACPI0010, Section 8.4,
-       and more specifically 8.4.3 and and 8.4.4).
+       and more specifically 8.4.3 and 8.4.4).
 
 MADT   Section 5.2.12 (signature == "APIC")
 
