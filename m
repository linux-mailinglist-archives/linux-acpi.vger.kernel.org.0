Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC9D62EABB0
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Jan 2021 14:18:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728531AbhAENQe (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 5 Jan 2021 08:16:34 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:54833 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728502AbhAENQe (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Jan 2021 08:16:34 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id CF5805803D8;
        Tue,  5 Jan 2021 08:15:27 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 05 Jan 2021 08:15:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=ovzRNUOoirUfsc2LW7sL2wtDm5
        7aYO8qZI0AlhpAeIA=; b=de5ituPcFvcJH+RYJx1y2IcsAgBv7O2w2ri+QmFJXI
        L+U8Fz6keseJQzAVCGR4JyChzfcQBROW+sC6lhNINq1h3yzxmh1ev9t0UWKf37Ri
        xDGGy9ajQ4VjfqaOyoOZAM31Mrc7sp342A2FwgLqeuKYTrmdl68k4wGN7M5b6Gyv
        gVMpkBFp/xv1Z6/ctItDxSDcRlGE1P+b5hsSL2yzdVtJ0KjbeBHV/UlqfVUdzK6F
        vjeI1C3n3msmOZc5ShZmezbr2zZq4TQVuFoIprySn63Xx/V4BYycgtFtDd5vKHFD
        3FccYzGMXGjFy3QoMQzNuoyFdYvdHpf/IIYH7+0XmK/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=ovzRNUOoirUfsc2LW
        7sL2wtDm57aYO8qZI0AlhpAeIA=; b=XLFtUSgfh9I4uIAz1wGOioZcRbRB1e2Hm
        hgTV9/aSD0ubAGBz6dQEhbRTnhLz598llazSNNL5cOIXskPwlW12K1Ba7giEAoPx
        pjCQKnBYdHRuXQ/5/La4XJIBc0ofXbpYDaEblg9I9Io3Nz/eX98YxBYSzKgI4MJi
        +Fn+OrnnZ9RjtZB69u+ziWeXVwSbUIdBml6gy0qly6rLAZ3ycKSkahHpACcsIAn3
        xbHhMUTewv2xJBYs+T5z3uutST71Zq7NAo23EpjGjDHsrXfFEIL8Nc7593wHwFM5
        06IpO8fyeyi2jzUeLI1azhpbmuOhJHvggdJ81+phNbbjiloFeWe7w==
X-ME-Sender: <xms:bmb0X_7lC1tnaKaXaNuMltEedRFC7Z4wbzU5kE79SqIMg9V0vC4QIA>
    <xme:bmb0X0490QZHjY6JC6_YtbJzjfJuCdYJNTU7vxOO36RbM9Ki0OgD-p7vznv-XIMZi
    HgXzGAh_csDgxrYlZM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdefjedgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeflihgrgihunhcu
    jggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqnecuggftrf
    grthhtvghrnhephfejtdektdeuhedtieefteekveffteejteefgeekveegffetvddugfel
    iefhtddunecukfhppedutddurdekgedrudekrddvudeknecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihg
    ohgrthdrtghomh
X-ME-Proxy: <xmx:bmb0X2eGcwNN6wNPxLhfPLZ0Dx4NFxdHIWCCA-P_5VCDZHaKydobvA>
    <xmx:bmb0XwIwyMA9v-1ohX1l7rGKtcPOq-Ldgq9jP6PDKQk8Dj6RkgwdHg>
    <xmx:bmb0XzIBeipVYh1Cn2hrJIwnUlcxJM6hGNel9MtT9csmkwov7w8o2g>
    <xmx:b2b0X7_GVlgnN7HO6kiWlxsySd8GKkNd9GoS1BGDoLYB889R3eUoyA>
Received: from localhost.localdomain (unknown [101.84.18.218])
        by mail.messagingengine.com (Postfix) with ESMTPA id B1AE324005A;
        Tue,  5 Jan 2021 08:15:13 -0500 (EST)
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
Subject: [PATCH v2 0/2] IdeaPad platform profile support
Date:   Tue,  5 Jan 2021 21:14:41 +0800
Message-Id: <20210105131447.38036-1-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Tested on Lenovo Yoga-14S ARE Chinese Edition.

v2: Use another private data approach (Hans)

Jiaxun Yang (2):
  ACPI: platform-profile: Introduce object pointers to callbacks
  platform/x86: ideapad-laptop: DYTC Platform profile support

 drivers/acpi/platform_profile.c       |   4 +-
 drivers/platform/x86/Kconfig          |   1 +
 drivers/platform/x86/ideapad-laptop.c | 289 ++++++++++++++++++++++++++
 include/linux/platform_profile.h      |   6 +-
 4 files changed, 296 insertions(+), 4 deletions(-)

-- 
2.30.0

