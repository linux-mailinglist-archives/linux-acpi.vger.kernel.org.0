Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38FF52F5B75
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Jan 2021 08:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbhANHly (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 14 Jan 2021 02:41:54 -0500
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:45203 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726806AbhANHlx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 14 Jan 2021 02:41:53 -0500
X-Greylist: delayed 386 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Jan 2021 02:41:53 EST
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.west.internal (Postfix) with ESMTP id 7B3B81264;
        Thu, 14 Jan 2021 02:34:39 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 14 Jan 2021 02:34:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=dDIFxzNu3vWVo+l1dCICe/VaE1
        aaZujoPHgnsTlqRZ4=; b=qS+bqO1czqSFZqRECl8C2AwWadpiT0Q5fslkVoV0aF
        IoYWtoUMRENXpnwKV/W40ZgTEdmUDidgpuJmY3mpVn1juNlrTk2FjqRNhxR8ZgoJ
        3V/n97I984/IUiFJ9jxAUj4m0XhGjFblPEsmlhukVsyhPoEE/QVK+c5eGsnzfa52
        fxcJBtjDLgzSb3O+ut5PuT7F2IBjYp2Py/2uyXCSP+ziZFv+P/InsV9OA2Y+Fmql
        J2kQ/68WbpYVukoSbXZFDMtB5pFILFXI4HXkQv+ez4LwK9rWjVME6tBC9U/3s+w8
        /EDYet2pP6o2ClQeG4K9kBKX7SSWAw5UX14VuTUgHseQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=dDIFxzNu3vWVo+l1d
        CICe/VaE1aaZujoPHgnsTlqRZ4=; b=VWG+Zja+aD5qGDpdpQcH+Vrbq8wq0ReOU
        RwiEmRPVhv/2pGbYp4BMTv6/YJAuA1rnK2tQzvZC5fvVuLO/QHKtoFC/1UC8lxO7
        +2y0YWlsyJXy2oSfY8emEn7BqIFPEHiKJ9CdDW8oAavFJWInTbdbUy3ct5W0ww4w
        TQvR7Or2I6gqX2exvnOV9BxxGShHqEs5FrtRg1H5s2OXzKE7NdCyjDL/7N2RYy/N
        wyeLMZX/kCXsrf+fhDQGXYxt85ar9fdGepgGlzg61AH6mMCFjv+BbEd7M1V5LrZF
        Igm/IDt8buPwmfC1ufu9iUAuWHHBCTZMrf6ajva56g9nIXij348UQ==
X-ME-Sender: <xms:DvT_X_FW0Ir--91IHqAas9PObZ4goB4MV9l1taT6rejNugcpqfetRQ>
    <xme:DvT_X8Wm87RgjfP2ucCbPbH6WF-YskmIWBON3ijWlnwmNa5e4VmGYP55ta_xJEG21
    nZGvIlk753igvFE_ws>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedukedrtdeggddutdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomheplfhirgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehf
    lhihghhorghtrdgtohhmqeenucggtffrrghtthgvrhhnpefhjedtkedtueehtdeifeetke
    evffetjeetfeegkeevgefftedvudfgleeihfdtudenucfkphepudduiedrvddvkedrkeeg
    rddvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjh
    hirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:DvT_XxJYj36GoqLCquvvWY4BiEYgPNKcbhyVYrotAgicVWdwbS2Ryw>
    <xmx:DvT_X9EXpL1l7qLid52MG4mre5K6rOJzM3JD_W-VYHtH2oApnS1HAg>
    <xmx:DvT_X1WuM5vbQKjGDmWYcBCQo9ZMc0PE4A2CY_qqoKrbj0-e-aJ00w>
    <xmx:DvT_XyhRBNUH8-C3ZyvN1m2PCrLf2vtWQalgpydZYowYnWcrHahHy-uVCtU>
Received: from strike.U-LINK.com (unknown [116.228.84.2])
        by mail.messagingengine.com (Postfix) with ESMTPA id EA0A4240062;
        Thu, 14 Jan 2021 02:34:35 -0500 (EST)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-acpi@vger.kernel.org
Cc:     linux-pm@vger.kernel.org, rjw@rjwysocki.net, hdegoede@redhat.com,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH RESEND 0/2] ACPI: platform-profile enhancements
Date:   Thu, 14 Jan 2021 15:34:27 +0800
Message-Id: <20210114073429.176462-1-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Resend as previous mail has a typo at to address.
Replacing b417d9c7404df67b9be0104585fefb2ca8d36677 at pm/bleeding-edge.

Jiaxun Yang (2):
  ACPI: platform-profile: Drop const qualifier for cur_profile
  ACPI: platform-profile: Introduce object pointers to callbacks

 drivers/acpi/platform_profile.c  | 6 +++---
 include/linux/platform_profile.h | 6 ++++--
 2 files changed, 7 insertions(+), 5 deletions(-)

-- 
2.30.0

