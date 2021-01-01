Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75C892E83C6
	for <lists+linux-acpi@lfdr.de>; Fri,  1 Jan 2021 13:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbhAAM5u (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 1 Jan 2021 07:57:50 -0500
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:54701 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726604AbhAAM5u (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 1 Jan 2021 07:57:50 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 2D4875803CF;
        Fri,  1 Jan 2021 07:56:44 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 01 Jan 2021 07:56:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=VN9gFoYMofdXX2/sNpiOzvL02L
        G+6gSlPlV9GtM1Kfc=; b=sd0Fd3pvJJNbv03G4raVb6jSmjyMImU8Z6RCX4My8Q
        mCbPz0lW6CXPsont0kh63M/9bKYNlqI5WoYOO4pdiCwd5dhwO/NUA0JbUrIUe9ZN
        7lo9i5ZVDpgtDOJxbc/bh/mZOFssWUcIJi3fB+GgxOAfCNXErj1d2/u9sCU5z3+2
        +G+JMtAI/T5sU8nrQ8pkpMwUUxE5r/ecXM0atDjnEvs2l1SDhI2pkY5Mvqzirzvc
        nCvmPJD1Ft2Wv1dCJ7ZzCLllyI0dMWLNpYwviSnf5ls7HyQJgU1sTKQscyfmaQiJ
        EbyD7I/FYJ3AM3v2ZHZYu9CUC9ZVFBGXU85gCmKv/exA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=VN9gFoYMofdXX2/sN
        piOzvL02LG+6gSlPlV9GtM1Kfc=; b=ZyCQ3wtskd6wViZL+8hs1RE1j/k4rD+74
        tknJ3ZS4FpGDIVEMwUFiAXVtis3BnezFPyP/2iQaTK0XWpyAmdC8x/eJw6eJcJ7n
        PtwV8+EQDwnqe101Kht3ZrRa1eDlCajtceD+hmQbfTUcgG0UQy32Yg8MQoeUcVdM
        JXogDCLA0/oHmmYEUX7KVJsoMpnhY880x9EyDnRlKHOYcprRta3O0Fjr+8+22VhN
        QfMo8o9IkAATZZ3cQS7yC+8zesm8iGtxn9n9KCpnkGkcqyrpUHNFcQX/mkuKJDZI
        8hKSnY9DlGKANPRLiaIw2M6DxbryKPi4XpFUYZv8IKk+k4g3x9bpQ==
X-ME-Sender: <xms:CxzvX-H4xxVryl_FQCRVYdKfBbGhS6-4vC4CIQ-6x_XcqhoJ_ItXww>
    <xme:CxzvX_U5IcXq4NsvKz35iTd9aOSUWftjSyn4Eam6-JayZpaAVW2hUjHZLtyNXL5Fr
    uf73XhWwFIuM2JAh30>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvddvjedggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeflihgrgihunhcu
    jggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqnecuggftrf
    grthhtvghrnhephfejtdektdeuhedtieefteekveffteejteefgeekveegffetvddugfel
    iefhtddunecukfhppeeitddrudejjedrudekledrudejudenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhih
    ghhorghtrdgtohhm
X-ME-Proxy: <xmx:CxzvX4IjdKSZl-5ljBv3qMpkaUksKqifZz_jmyIpyh5i69gH-tvrrg>
    <xmx:CxzvX4FWFRrhWJHjHdXosEYIVg2_8YeNIy_cNhjXHuQE-42Ouq0Adg>
    <xmx:CxzvX0V__R-ScF_6BvwrndGlggyLm2f07ObFdN3yvsRzprQhZMkOyA>
    <xmx:CxzvX2JYGem75q2ZAMZlCZ58IZjwUDrQ7-SBTN7myeCoKrDghESTqg>
Received: from strike.202.net.flygoat.com (unknown [60.177.189.171])
        by mail.messagingengine.com (Postfix) with ESMTPA id A70B6240057;
        Fri,  1 Jan 2021 07:56:37 -0500 (EST)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Ike Panhc <ike.pan@canonical.com>,
        Mark Pearson <markpearson@lenovo.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] IdeaPad platform profile support
Date:   Fri,  1 Jan 2021 20:56:24 +0800
Message-Id: <20210101125629.20974-1-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Tested on Lenovo Yoga-14SARE Chinese Edition.

Jiaxun Yang (2):
  ACPI: platform-profile: Introduce data parameter to handler
  platform/x86: ideapad-laptop: DYTC Platform profile support

 drivers/acpi/platform_profile.c       |   4 +-
 drivers/platform/x86/Kconfig          |   1 +
 drivers/platform/x86/ideapad-laptop.c | 281 ++++++++++++++++++++++++++
 include/linux/platform_profile.h      |   5 +-
 4 files changed, 287 insertions(+), 4 deletions(-)

-- 
2.30.0

