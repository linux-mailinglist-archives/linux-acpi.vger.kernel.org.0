Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9695449A3
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jun 2022 13:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243370AbiFILEA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 9 Jun 2022 07:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243345AbiFILEA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 9 Jun 2022 07:04:00 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CDCA366AC
        for <linux-acpi@vger.kernel.org>; Thu,  9 Jun 2022 04:03:55 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id s10so1316601ljh.12
        for <linux-acpi@vger.kernel.org>; Thu, 09 Jun 2022 04:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8uYu8lJiNuFARRdH3Dv0gK66JWjRf/8va0hEQMAWSVE=;
        b=EMsI0ApUkRgweNKPg6JQ59+57gorw/10/iLwDPMox+DFf4tFX79NVzId4ZnoYaSeIo
         ItBVH0yUXDl/dOKnowxrWthfkBO14pmFh/pObvY6R0XlN9RXXcUOJdXlciyD9tbNE/mb
         7DoUyRDn5YzZDhSgtQYR+fraUF/bEIhS/QWB0o30u0oAZR49OSDY0FkV1Yg3zUxN0xoD
         BUuJbojVzCL4rxEeIqfAcpRmngggYe/yr0HDMluZjStSaKFZbviwIT3BhLa2OtxLMKlA
         9HWXRq6Wg8xi1TBsjlw/rPqpLweQiO/oDugVTY7SsZXfCNHHWJ2N37A3QNlSw/qAG6QG
         F+wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8uYu8lJiNuFARRdH3Dv0gK66JWjRf/8va0hEQMAWSVE=;
        b=r+Sdxux0PpCdXTypwtrkeW3fBnKtOSIZt0UvHNzjgja0IvFSIVq2p3M+ydJlzv7xXA
         irg2JcTtQfcDnZxLTEz30YkZ+9+MlRf68Q26eNEj0RH0wVfPF00BKeFk8sQU0454YB6A
         8yxN3LarlD13k2zO31ADDrxbmYaKXs9lQ0eNh2R9GIzCIjPCi0qrdq8DxKw1cqsqArPf
         Ua1QDZX5eKKUPu16jt/gfFToAwFZmtPY5nPX1ls/qIgIrrNI42EehQ0wHncXC9dReHrU
         ulqM1D+gzRLvXu8DPrf70HT4oMdd/rkjHBQNRRLqEEU/6E0gJQ5CNESrXI3HcdxkZPE7
         vleQ==
X-Gm-Message-State: AOAM532OC3uvCTP3HN1WrS2voTmmFXk1C1TgzEfJzq9Bu4w23ZH0eFYP
        IDIz3+Q+8ts1FB0sfMj++6GuaA==
X-Google-Smtp-Source: ABdhPJzP9OHSzABmTycdeFyssS0y/yZjxyhfETt55oRQaQYmjEFctwgh5JRBToJgpzHJlNQ/K/jgqg==
X-Received: by 2002:a2e:b5c5:0:b0:255:5ba4:4892 with SMTP id g5-20020a2eb5c5000000b002555ba44892mr26027566ljn.3.1654772633411;
        Thu, 09 Jun 2022 04:03:53 -0700 (PDT)
Received: from jazctssd.c.googlers.com.com (138.58.228.35.bc.googleusercontent.com. [35.228.58.138])
        by smtp.gmail.com with ESMTPSA id a10-20020a194f4a000000b004793605e59dsm2116674lfk.245.2022.06.09.04.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 04:03:52 -0700 (PDT)
From:   Grzegorz Jaszczyk <jaz@semihalf.com>
To:     linux-kernel@vger.kernel.org
Cc:     jaz@semihalf.com, dmy@semihalf.com,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Steve Rutherford <srutherford@google.com>,
        Zide Chen <zide.chen@intel.corp-partner.google.com>,
        Peter Fang <peter.fang@intel.corp-partner.google.com>,
        Ashish Kalra <ashish.kalra@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sachi King <nakato@nakato.io>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Wei Wang <wei.w.wang@intel.com>,
        Fabiano Rosas <farosas@linux.ibm.com>,
        David Dunn <daviddunn@google.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        kvm@vger.kernel.org (open list:KERNEL VIRTUAL MACHINE (KVM)),
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        linux-acpi@vger.kernel.org (open list:ACPI),
        linux-pm@vger.kernel.org (open list:HIBERNATION (aka Software Suspend,
        aka swsusp))
Subject: [PATCH 0/2] x86: notify hypervisor/VMM about guest entering s2idle
Date:   Thu,  9 Jun 2022 11:03:26 +0000
Message-Id: <20220609110337.1238762-1-jaz@semihalf.com>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This patchset introduces support which allows to notify first the
hypervisor about guest entering the s2idle state (patch #1) and second
propagate this notification to user-space so the VMM can take advantage
of such notification (patch #2).

Please see individual patches and commit logs for more verbose description.

Zide Chen (2):
  x86: notify hypervisor about guest entering s2idle state
  KVM: x86: notify user space about guest entering s2idle

 Documentation/virt/kvm/api.rst            | 21 +++++++++++++++++++++
 Documentation/virt/kvm/x86/hypercalls.rst |  7 +++++++
 arch/x86/include/asm/kvm_host.h           |  2 ++
 arch/x86/kvm/x86.c                        | 18 ++++++++++++++++++
 drivers/acpi/x86/s2idle.c                 |  8 ++++++++
 include/linux/suspend.h                   |  1 +
 include/uapi/linux/kvm.h                  |  2 ++
 include/uapi/linux/kvm_para.h             |  1 +
 kernel/power/suspend.c                    |  4 ++++
 tools/include/uapi/linux/kvm.h            |  1 +
 10 files changed, 65 insertions(+)

-- 
2.36.1.476.g0c4daa206d-goog

