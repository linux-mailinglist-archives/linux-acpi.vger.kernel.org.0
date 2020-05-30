Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 802941E9146
	for <lists+linux-acpi@lfdr.de>; Sat, 30 May 2020 14:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728989AbgE3Mqm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 30 May 2020 08:46:42 -0400
Received: from mout.gmx.net ([212.227.17.21]:43683 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728979AbgE3Mql (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 30 May 2020 08:46:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1590842779;
        bh=oPdJl+VzV24Bq81FHCLzq08lkWhQIV9dZZxlAWUssXs=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=hbG6vPzqCe+1eIbbuo+qRekVBCJJxzFtV1K/Pea0QEX+8pTjkV2DJfqyAE7WAtLBL
         dNyyqWaFYMcyoKontn+AEehlPXz0x/DSPpaIcLPVpO7oASA0qzvG/Q7pWTI5l/LLWp
         Bv9z65TRmB4ZFJu3vh4MEPJJyqbwMo0Quj4EFciQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ubuntu ([83.52.229.196]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MO9z7-1jLPYQ0QOX-00OTO4; Sat, 30
 May 2020 14:46:19 +0200
Date:   Sat, 30 May 2020 14:46:06 +0200
From:   Oscar Carter <oscar.carter@gmx.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v3 2/2] drivers/irqchip: Use new macro
 ACPI_DECLARE_SUBTABLE_PROBE_ENTRY
Message-ID: <20200530124606.GA29479@ubuntu>
References: <20200529171847.10267-1-oscar.carter@gmx.com>
 <20200529171847.10267-3-oscar.carter@gmx.com>
 <590725ccfadc6e6c84c777f69ee02a62@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <590725ccfadc6e6c84c777f69ee02a62@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:O4ZjVuk7dgddTzBSN0ZnC8xOh36wLCSpKRpRgiCy4+M8PkuJQOx
 FL7bg3CFu89himtCZ3K/cz7GILT3EPOgIZG472jLjEporsYzf7YRexfMy/IM3wFcz1JOu3C
 vKkF+OSCarRdYg9BYFMXh0k+ICANDNtc9ERYEIu7Tih1tuTZK//m4LF0UzTnHaxKbq5mvOv
 bej7d+XHpEtOuwf19RCrw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:vBAdlEhdIRY=:aJJnDT/sogHkcgRTgFdKrR
 YcpxMY/W0VlpJ7k5ZjibbcPJ2J9ikivEB5dJ8QKnIaWcDEV/QvOjKUup5QoEdWlC7L1E1aXmp
 PCrDeTeau/Yz7VbyRhKJXrEiH4Jz5YAaxFToIAUa7QoLyYITgZSvPIV4kDC3bwDxVapCf/vS7
 XnpY5bhApD2/dueGYp19W84CH96mLL0cmObUwVciMqG22Mrxdfu4+1TgJBmBgMc89WQIaAqG3
 P+IAVBBPqNDsMp4tSRaUiufJwfRAHEFeL9oFXBazjtsYTr9oL0FdnnSSQBA9/dSe2LXqUqK3P
 V+BDsgSeqPROGhUUdEoQXkYXERiNfA90rQhzFaSqbtaQ0Ps+W+Oo7f4t+fXfUWS/dPq2pe+wE
 maEH9cS6/7Y1aN0cnAepjhXTfkAn0/v5oTfO6mMz9WtpRwbMkwpA/uRoIBJiS72Zftn40HmGc
 ob9n3WmMXC4l9xglx+uhZjisOicT7bAZ9pobVwvNeoxjTYGOCfXt3SIEzDpPX+O0fEgqE6eif
 H/Yqk8pC4muXlPwELgsHOvpMbOays1nyi4ME5Ytppa9zmp8HrO4rEa2sFRuFUT30ysu36gh9U
 G2/gqZC+gpoMaUFJ1RbqoMvW4Y3rxTFcTCsdpgodz0QC5tN5b5csZQACIW2xKjbnAweAcF15d
 8MrIC/KlB/AvjWyJ+jWddNb8FNaQnk8X7REUXPI3DHikcjfHo1dCcsZjAcpAMbXrkAwJLsXz7
 iVCs2y1lKMv4Xp80STDLiLLU++9tP4wkOe3mtgL9ZxUn8L6f/JyWJMH6nb99oywi799956UYd
 Dtu+7A0d04igp2PaXgqVSQgc0r5iE5JzWyQ19I1RmQVi8NzsK4TI8JZt66L9T2+jVgwnrvij8
 F/+V31iB6/I7Om5f0v4scKbEE81EJThKNBEeX2nSFz7qvwWVvqSW8HTDCjrNzOhNiEQbbdfmZ
 gG3T2yR7ap26cvOdqYOrJQ0XUSdLady30fZsRsfMTMzp/ASTJHaBBuuUem5w1hqVEB+SOfIxv
 ukk7Zqh+gBAnjD3QCMf4oPqH0/XatxhSr39/N2Y6GbA7V1lRpnU5u0f3f5KDkKRpx5hB6MhgZ
 JzMQSP2Vi+3+xBp4OO1b1tPhzBD7lEDDmsNOV1WHQw7SX03x/cBd4KYCCR4vW4SnJkScknLhw
 FA8hrVX6cHINvmjtPSOWOIcmKgJqIyPyf2WdUqR4VFyTu6OvinRdvSIejHOlGdQh3c+uzS9Rb
 Yz6rPUSrE1/x4O9P1
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Marc,

On Sat, May 30, 2020 at 10:34:51AM +0100, Marc Zyngier wrote:
>
> I can't help but notice that you have left the cast in
> ACPI_DECLARE_PROBE_ENTRY, which should definitely go. Probably worth a t=
hird
> patch.

Ok, I remove it and resend a new version.

> Thanks,
>
>         M.
>
> --
> Jazz is not dead. It just smells funny...

Thanks,
Oscar Carter
