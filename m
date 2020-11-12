Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D30CF2B03DD
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Nov 2020 12:30:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727147AbgKLLah (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 12 Nov 2020 06:30:37 -0500
Received: from mail.kingsoft.com ([114.255.44.145]:44122 "EHLO
        mail.kingsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbgKLLah (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Nov 2020 06:30:37 -0500
X-AuditID: 0a580155-613ff7000003c60c-d9-5fad190e1708
Received: from mail.kingsoft.com (localhost [10.88.1.32])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mail.kingsoft.com (SMG-2-NODE-85) with SMTP id B6.15.50700.E091DAF5; Thu, 12 Nov 2020 19:14:22 +0800 (HKT)
Received: from aili-OptiPlex-7020 (172.16.253.254) by KSBJMAIL2.kingsoft.cn
 (10.88.1.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 12 Nov
 2020 19:30:31 +0800
Date:   Thu, 12 Nov 2020 19:30:30 +0800
From:   Aili Yao <yaoaili@kingsoft.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     <lenb@kernel.org>, <james.morse@arm.com>, <rjw@rjwysocki.net>,
        <tony.luck@intel.com>, <linux-acpi@vger.kernel.org>,
        <YANGFENG1@kingsoft.com>
Subject: Re: [PATCH] ACPI, APEI, Fix incorrect return value of
 apei_map_generic_address
Message-ID: <20201112193030.6f384897.yaoaili@kingsoft.com>
In-Reply-To: <20201112103258.GA12908@nazgul.tnic>
References: <20201110120002.459078-1-yaoaili126@163.com>
 <20201110145450.GA9857@nazgul.tnic>
 <20201112172407.432b88cc.yaoaili@kingsoft.com>
 <20201112181203.6c39d096.yaoaili@kingsoft.com>
 <20201112103258.GA12908@nazgul.tnic>
Organization: Kingsoft
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.16.253.254]
X-ClientProxiedBy: KSBJMAIL1.kingsoft.cn (10.88.1.31) To KSBJMAIL2.kingsoft.cn
 (10.88.1.32)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrILMWRmVeSWpSXmKPExsXCFcGooMsnuTbeYPM+MYvPG/6xWdzft5zJ
        YufDt2wWy/f1M1qcOX2J1eLNhXssDmwe31v7WDzWzFvD6LF4z0smj02rOtk8tlxtZ/H4vEku
        gC2KyyYlNSezLLVI3y6BK6Nr6iq2gs2MFW8eLmFqYGxk7GLk4JAQMJF43ePVxcjFISQwnUmi
        58s+FgjnBaPEtyezmLoYOTlYBFQlbi68ygZiswHZu+7NYgWxRQSUJL4umgtWwywwiVFiR1MW
        iC0sECmxf80sdhCbV8BKYt7BHWD1nAKGEgf27WSFWPCcUWLt/JVMIFfwC4hJvGowBqmRELCX
        eP73LDNEr6DEyZlPWCDm60icWHWMGcKWl9j+dg6YLSSgKHF4yS92iF4liSPdM9gg7FiJZfNe
        sU5gFJ6FZNQsJKNmIRm1gJF5FSNLcW660SZGSCyE7mCc0fRR7xAjEwfjIUYJDmYlEV5lhzXx
        QrwpiZVVqUX58UWlOanFhxilOViUxHlrzwKlBNITS1KzU1MLUotgskwcnFINTCEbavIe+0Tp
        VPHExDjHXyrj1e/mKTmyq99h/VbvwEcNKa3Tb3rx9Bf8LtHYFcMQfrpvUpOIZ9Xtt5Vx2Qc5
        eJ+u1BJkrDlU2/FxopjTbIvp8/ur3m8L3brlhJCW3sNX+1PPnD5oc2O75Gu2BYs+Jyqc36UX
        6xZyNueBxManZbdzLngzyVVU/PiyRdb6zHyXuawGcT0hN/yXOupaJLTbJT2zZtLIerlZ40Je
        oG7uhr6HGS5csW/VvhtP9XlZ8e4EUz/DowP3L+9VN1rhW6L3J2/7xPuNNaxhusseXZx209e8
        S6+oKVsgvbk25pCu2+t2z0eZBp2/L4s0M7j8uVZy9WCRxuLffzfZf0xaU75MiaU4I9FQi7mo
        OBEAdbP5EfQCAAA=
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, 12 Nov 2020 11:32:58 +0100
Borislav Petkov <bp@alien8.de> wrote:

> I hope it is clear now.

Yeah, It's clear!
I will avoid doing that.
Thanks

Aili Yao




