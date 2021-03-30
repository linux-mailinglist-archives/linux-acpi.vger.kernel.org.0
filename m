Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E47434E029
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Mar 2021 06:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbhC3E3B (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 30 Mar 2021 00:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231469AbhC3E2t (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 30 Mar 2021 00:28:49 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65AE0C061765
        for <linux-acpi@vger.kernel.org>; Mon, 29 Mar 2021 21:28:49 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id q6-20020a17090a4306b02900c42a012202so7005059pjg.5
        for <linux-acpi@vger.kernel.org>; Mon, 29 Mar 2021 21:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=platinasystems-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cDPnFDoSnmbQbsbTE9TiqCutacndX/GABTAnh5LIxOo=;
        b=N5xEHoNpWI03TNelSmLiM8Xezkdb+TyjL4LJ3kDUwnEFtpoCfCopUzCPooLKVdvKi0
         bn5YVg9X8EoltkLdFkrkPI7ldJt3zHDZXKyMPI4nMQo3NDH7ntTfUSzgSOyNffLG7Dd0
         JHMO5ZbqX56hLx/hN/4T6A6MKw6DP/5Hb0B02VpeL9Iw0x1XgXp0Mi8TmFf7Qxgq8R4d
         CAApY5jujFiu35uICjptFW2rQSxjy5xTj+j7lQXXhhKMXvqSs/YbiKGf1uyQMsiwHNma
         J4N6DatGZHDSGb/gBaoiBLnVmmxNISJFA3hFualR6GEi/enrMsfB2Nyb/60wHY8FspEL
         zi9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cDPnFDoSnmbQbsbTE9TiqCutacndX/GABTAnh5LIxOo=;
        b=YS9ggs5Xa7DHbsm5G81MLUwnLgs8uyMO8/psvvNwXQNCqoamxVemKio6PjszigA/4r
         77kKDVdiWV4Yjrc5LH2+fgmB1psuSacIRkuVp3qIO7ELNWN3k9ew2ytezBxUebnZZWfg
         Od31fBRL3Qo4m+TgFAjPNMq5M7xhI85drdJYzmxaoMJXv9FCf9CEJxXgpkC71FXkev8A
         amzCSTZkQcSez4djiwJkPdfuU82TheqHcfzYdEn64DOtqgpboB4DukT8fcHm5wJXXLJY
         ab7qXCr9wCjCeNFOqrgRhu2AoA5VG4LIqxbgyWD8feklGyE5el+We7A+v8rK8gIEU/gL
         wQ2Q==
X-Gm-Message-State: AOAM533W2IVNtLhjQZlqwR18dEB5hcf5syCw96Rtefycg7Zy21Gf8iNY
        /kKQAJbdcYQyXJ7cLjUy9wFJSg==
X-Google-Smtp-Source: ABdhPJz9JsYr7IxLi9s0ozkkLjoeVG+PGFs66JQzgUb/oYpcNcUtvdUfT8okH5xHpBofpYWO1glvqA==
X-Received: by 2002:a17:902:ce8d:b029:e4:bc38:c4 with SMTP id f13-20020a170902ce8db02900e4bc3800c4mr31006229plg.48.1617078528794;
        Mon, 29 Mar 2021 21:28:48 -0700 (PDT)
Received: from localhost.localdomain ([207.53.255.56])
        by smtp.gmail.com with ESMTPSA id o134sm18779565pfd.113.2021.03.29.21.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 21:28:48 -0700 (PDT)
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
Date:   Mon, 29 Mar 2021 21:28:32 -0700
Message-Id: <20210330042833.2945702-1-kph@platinasystems.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210329223827.2851916-1-kph@platinasystems.com>
References: <20210329223827.2851916-1-kph@platinasystems.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


The original version of this patch correctly stated that the only
wrapper needed was for of_nvmem_cell_get(), but included only a wrapper
for of_nvmem_device_get(). Replace with the proper wrapper.

