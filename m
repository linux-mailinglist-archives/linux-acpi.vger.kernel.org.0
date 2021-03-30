Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 177F434ED94
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Mar 2021 18:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbhC3QSs (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 30 Mar 2021 12:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232376AbhC3QSa (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 30 Mar 2021 12:18:30 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9301AC061764
        for <linux-acpi@vger.kernel.org>; Tue, 30 Mar 2021 09:18:30 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id l1so6417989plg.12
        for <linux-acpi@vger.kernel.org>; Tue, 30 Mar 2021 09:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=platinasystems-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Nav8LadcpFIxdskcDBBNZMpNM5ijLXJvIdbPHCb3P6k=;
        b=CyGQt6icjhD10GaQAeQisHngs3kN/4kJsMfK6abeb5qKWv9Vd5f+445IeGRhGpIfuj
         6pJxgjgn5d6zgep4sUfokmWWi2SdroztqdRiQxtnKyR0ST51Do27fP0vYFcwY3q9l2/J
         ZrRHVY5WML4iymb+YQCWL/KqPOFWOsMLJU+akIYbHpDT2UXeDzwziY72W0Z8EBZTXx7n
         6bjZtdP9dmt5Vnz/xm+PsC0f+tQninRwFkj2us6NjXkA2Npmha1mn+FIyPdwpS9hzObC
         W6CBEAjXbkEAtlTm+R1a1qJEyQNCZp7XwkqUFPjg+AfqzR6c63OtZvaVknDv8N7gYxFt
         mPrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Nav8LadcpFIxdskcDBBNZMpNM5ijLXJvIdbPHCb3P6k=;
        b=hzAA1VV4+kZIYSVKljPpUbE2SCXD5Pw+TIctFMWlmukiwHgTd+fV2IqV9N/uIopoat
         Z6RFlRZYDL2BgLuK2tL6K3JYXKpg11pAQrKoJEdJu/kwlSAZ25JxUyK1z8dD2bx0J/gE
         WpKPfVqJduZPpdP7mhEA6o2pXk/wmlTlYA3vbRkjpSbWNT5/hPKOLNdiOeevKkYiYnI+
         U06MfXmRqDZqb5ff7Zx8UZdgYYdbZq6pkmgFL9ePOylTZPzGbI780dngO4J6ySX70H0f
         AVjp7ReyTlYcn05PM4BnVZCd/DNFposLNy5OGlx2E6IX1+nPmvhVvC3LzdKycOCL7wIR
         m4HA==
X-Gm-Message-State: AOAM533uwSKK2UzxRpfXfCJTc2JW9psT20JMb3lUOPmDKFoQN0QqmsHT
        wN31+ejX2DQXvYrKx9JFR1A+SA==
X-Google-Smtp-Source: ABdhPJyoZ9vhg9J78woeiM37PYeuWAAcn0Fw9i/T5uw4eC/r8Ot9VRpuRcERpNgh1WXJgtOPjPw2cg==
X-Received: by 2002:a17:90a:7045:: with SMTP id f63mr5069092pjk.35.1617121110100;
        Tue, 30 Mar 2021 09:18:30 -0700 (PDT)
Received: from localhost.localdomain ([207.53.255.56])
        by smtp.gmail.com with ESMTPSA id q34sm21040555pgl.92.2021.03.30.09.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 09:18:29 -0700 (PDT)
From:   Kevin Paul Herbert <kph@platinasystems.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org,
        Tom Grennan <tgrennan@platinasystems.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/1] nvmem: Change to unified property interface
Date:   Tue, 30 Mar 2021 09:18:14 -0700
Message-Id: <20210330161814.3144336-1-kph@platinasystems.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210329223827.2851916-1-kph@platinasystems.com>
References: <20210329223827.2851916-1-kph@platinasystems.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

nvmem: Change to unified property interface

Change from using device tree (Open Firmware) APIs to the unified
'fwnode' interface.

Change of_nvmem_cell_get() to fwnode_nvmem_cell_get(), and add a
wrapper for of_nvmem_cell_get().

Change of_nvmem_device_get() to fwnode_nvmem_device_get(). There
are no known accessors to the OF interface, so no need for a wrapper.

The first version of this patch incorrectly had a wrapper for
of_nvmem_device_get(), even though the comments about the patch
not needing this were correct.

The second version of this patch had an incorrect return type for
of_nvmem_device_get().

