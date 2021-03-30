Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4856234E019
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Mar 2021 06:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbhC3E0y (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 30 Mar 2021 00:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbhC3E0x (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 30 Mar 2021 00:26:53 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37391C061764
        for <linux-acpi@vger.kernel.org>; Mon, 29 Mar 2021 21:26:53 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id k23-20020a17090a5917b02901043e35ad4aso8789179pji.3
        for <linux-acpi@vger.kernel.org>; Mon, 29 Mar 2021 21:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=platinasystems-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=amQkhd8fLGZRPPJUB14300VNr0MzcVU8fRDKRIiZlqg=;
        b=ucGgrCSgKN4NQH3jj2HTuP7UG01/lAvGmcGLx2ufrA06x5fHrsLN8WK+++ueE03Kax
         JGoBAlFtoeFKp8ptjRKoJYzDJ83BMNee/IXlXVUZPNx66tMZtQjWIVFhoFrolOeHz4Vz
         K/GyFxLNMuDARJ2KBcKzSuIJ9p/JjDuWsHJcnqOrR/AfjSONs0ZQ4tyCc22KiuAt/Hvn
         15B0vQtpMd7dQ1wQldrxs28Vp/+0U4Zm0oVSlLBuUr9eSddhBUgNqBlriscG0IqNd+L/
         y/FlL3q3VLXjbNaDyVAerAxraF1PpOi9YYoGogVzdT59YrkvqD2uPHEYKKQWzhscDl6U
         Si8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=amQkhd8fLGZRPPJUB14300VNr0MzcVU8fRDKRIiZlqg=;
        b=sE0XysXpaCYy4+TjGSoeuNs7vsFtHpj3WI5MxSgM23h+4QVU+LtehSIgdrGSZ246BR
         t8HypA4QFnYGwlYvblQwhkjfc+n/Iwc7eN7RYA6x0eza0v2wpfF2NfhEJ4bDBu039Nez
         J8SfbNljvv0pnC8SXCSZx1jOxDrwb6bvXDGay4+tc21dvr9xhfkcOi0xbTr8XAfOLg2K
         nTjIVuCiXdYDoPB7YQQ0hmsU2Cny/tQqDnfk1LTmw9G3K4k0gCg8v3Nak6gjJnVADH/Z
         WBgn9gWIH3t4JwUps567Vot4yEk+DU9mEIId27nKl7couXSUGNg8lucZpGexMTFoc9rp
         yz6A==
X-Gm-Message-State: AOAM532LRUU6Hc/sfj1Ed0gv+GuWPulQYkA5rqzmyfodtHKtYyXeOPt6
        fgYsIMru9iLS7OLVO50qcxZOSg==
X-Google-Smtp-Source: ABdhPJw6H1zvqQLUhtLSXn5oyGF04JK5wkHdAbb80IUmCZYpHnTABgYPMnislkAmdg3wNSjs+71XZg==
X-Received: by 2002:a17:90a:8981:: with SMTP id v1mr2511490pjn.230.1617078412686;
        Mon, 29 Mar 2021 21:26:52 -0700 (PDT)
Received: from localhost.localdomain ([207.53.255.56])
        by smtp.gmail.com with ESMTPSA id q95sm1245973pjq.20.2021.03.29.21.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 21:26:52 -0700 (PDT)
From:   Kevin Paul Herbert <kph@platinasystems.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org,
        Tom Grennan <tgrennan@platinasystems.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] nvmem: Change to unified property interface
Date:   Mon, 29 Mar 2021 21:26:31 -0700
Message-Id: <20210330042631.2945107-1-kph@platinasystems.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210329223827.2851916-1-kph@platinasystems.com>
References: <20210329223827.2851916-1-kph@platinasystems.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


THis first version of this patch erroneously had an unnecessary wrapper
for of_nvmem_device_get() even though the commentary properly stated
that the only wrapper needed was of_nvmem_cell_get(). Fix the code to
match the intent.

