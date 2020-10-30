Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAD1F2A01BC
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Oct 2020 10:48:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725888AbgJ3Jsi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 30 Oct 2020 05:48:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24616 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725808AbgJ3Jsi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 30 Oct 2020 05:48:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604051317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ltAH/0JbbnJaW6G0EGTM6uVy3FwVGtWVpce8mBsNRgA=;
        b=T8no4HuSY4VWCYFg2aeajnMRVqvXwqFLL/8KOWI9R2M39CSyyAqRuv2i4Owp9bDDFysMF1
        S2rzUUM44zZ/jUE6zklo4Ael1RjGZ0zv81N1Cj/cNYCO4N62aDmyV16N1cHvGanYoOwEkL
        5X1jMf7YQ538/Yp0LsBzV3KMEx1o0Hw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-480-FrVoNf5XMAGzlPhOVyeYwg-1; Fri, 30 Oct 2020 05:48:35 -0400
X-MC-Unique: FrVoNf5XMAGzlPhOVyeYwg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 62A4480474B;
        Fri, 30 Oct 2020 09:48:34 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-114-237.ams2.redhat.com [10.36.114.237])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 262595C1CF;
        Fri, 30 Oct 2020 09:48:33 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy@infradead.org>,
        linux-pwm@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH 0/3] pwm: lpss: Misc. cleanups / improvements
Date:   Fri, 30 Oct 2020 10:48:29 +0100
Message-Id: <20201030094832.18297-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi All,

Now that the pwm-lpss / pwm-crc / i915 atomic PWM conversion has landed
in 5.10-rc1 here is a small follow up series with some misc. improvements.

Regards,

Hans

