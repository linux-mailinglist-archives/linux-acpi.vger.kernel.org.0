Return-Path: <linux-acpi+bounces-21239-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ANa+C6f1oWkwxgQAu9opvQ
	(envelope-from <linux-acpi+bounces-21239-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Feb 2026 20:51:03 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A121BD192
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Feb 2026 20:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B592F308F8CE
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Feb 2026 19:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F347C46AEDE;
	Fri, 27 Feb 2026 19:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="q2M/f2JX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7D0345CC2;
	Fri, 27 Feb 2026 19:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772221843; cv=none; b=LRdQNzKEhOLwB1sUkoYXTF8rVJcztWY0d0wZ8BoUqT7xDefHH6ShAwEjt9Np9x2NUbjGE66/TiNuyLMigOJ9SnCWWP5wykCUKO1XsvySgR7DmqjaRSxhunvxMGmOmPyo6qC1geWVgZUXiSrOq2iYnPeiKxygGjr58ehU1LF5c2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772221843; c=relaxed/simple;
	bh=UC0SibXVhehVK2ElFUdMqlRblMoQNPrP/b1it1JbwqE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zfb4aZWJbZrr69hzLlU5iDkHYDzS/g1BKEcHkRbBfdH+8uZWacf5B9nhNBuqR0k+MeYxFNODtpbdXmmlpef8BV55ZJdnIL6Snc6ZubGM5VaiQKZ6A09D1LcaQaKIhP54wFWHr4Q4mjO5NtvgdKHo6qhb2yW4DDex9ZOgQS6pCns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=q2M/f2JX; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1772221836; x=1772826636; i=w_armin@gmx.de;
	bh=ZlBCZNCqdMz6gdrOV2nuOW/Mmp7PQXqbXvoN+FSWiMo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=q2M/f2JXFfAK0+fLyDuEYy8X0mNEPDUAJwsbk79qmX2kl2J8P82MR+HF/5uRtXJe
	 HKRymm0TqeEiO4VHKjv0M+LJXugQc0DB3UMQKh4eIJAuJ+cKIrWwNp2O7BJ3zFDij
	 1sKpT+kMzpgpth+U6r/fE2KD6ItPwthaZmml8J/DRpWSrGW38TC4wUlYCxVxxO76L
	 cD1mfOdzG017NsM3WHsB0Y1AqcgRd6/hALNu+Y1+COl8BK2lqIkUOW9aIIBb14rPO
	 J9/92mmJ2hVoKJQDR2q27EgBpWyIxnTlG4hb/NPrk7VGhCvBEQXfPVsrcITElUlCq
	 SoCn5vE9Tms8dnBh+Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MpDNf-1vLr2S3IdT-00cONK; Fri, 27
 Feb 2026 20:50:35 +0100
Message-ID: <c663548b-29ee-4d23-a6b7-9a88eab5470e@gmx.de>
Date: Fri, 27 Feb 2026 20:50:34 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ACPI: OSL: Poweroff when encountering a fatal ACPI
 error
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260204212931.3860-1-W_Armin@gmx.de>
 <c5d23d8a-8f58-48c3-90ca-5d1a46964280@gmx.de>
 <CAJZ5v0g6w_2+4oUytzxHtAhsJczK9pe84ZfXPeOcjKqU0k_GkQ@mail.gmail.com>
 <6825e6b2-802b-4cd2-b2c5-b4eab67b00e4@gmx.de>
 <CAJZ5v0h7Nc2gUr_WaJSL4vEekhfL_4aojDWdkidnS=3T-=uxRg@mail.gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <CAJZ5v0h7Nc2gUr_WaJSL4vEekhfL_4aojDWdkidnS=3T-=uxRg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UPkjQr5eU3a0CNyLRBwKoTYQ6pYsZVNZi8PEuPWTJshn8KCYGlI
 50SPEuyDh5oQ2ke1Roud2AJVtbyqgIb+YPwJdW7Xz7ftO+ZB33bS8zsKpPVzrSXxl4UsFRu
 7fwbipYCs6xB8FbR6a549Vq8++Ww5aAL9FuMM4cXL3QB6RVLqcsiwZ/s4zoh4rla6q0bvci
 7JdNM68LO3RUJuTmszQXQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:i8lsoR6lKFc=;b4bmPpiNfN7wMXnpibXQ1ZppiqV
 IlGup2CUeyCD1BEsoI26kuxZNSYBPllBZVJB7xOqLteWovb4jdjQQEAytww/39l3xskr9EOFl
 hcKsAIxoaEE+8WUo0fag6eKv0+7c4vb+Nubzx2ROemUKHmFB4C3hepejX/iA4GLDuaxkh9z8k
 rcGL8zRTVmxEEZWrTR4ZNjM2Otigi9putZjLBsxRZ1aaDz8gmpzb/0ON2wjF/gbJZKDN8NzTT
 BHg+GVGJHfMk2jGKI8eP86x9UYQoOsuGSLuU/WLojDrgkjQj+fVnrDM91olsk2fk0RKIK1mrK
 18uTanb4vy+mzEcrS10uBqrGlLU0gkB32Pv9RSZSUwLO8EleY7xNrpaksHdD3yGhv7LRIAgXH
 LQiXvHiph+1wxxnnhQ+FZ+MG0YLEG/owUKNG4KuZA+0ZzgyT6VM4o6Wr31gWDfI81IVBhlf5F
 INRfmdBFYJBjSsZIpyeC8fWHLPEzbZdPz1g6BCrKyT6uuQSPHEPL1MTpPc4wF5TNw+sultrvY
 ITdVwrDe2uX27bZ3iWHPIjPjL0kwZ6ZRzlYCi9AcXY1GB2nCAot4qj8C77pv2pTSkutayIELz
 ZcYzXpP8cRYxjH45epHNZNPGcqWztnBMMCa6UZ0noqyqG1w6Y+WP9HuNhbPxwRb23MG0NAOh6
 dOdbKeejHFf/ytUJEefGWp0AqZtQ7yAfiv3U5afLVIlpg53TSrfpINrpH8OpTauB9qDpW96kd
 CzdVGKkTJipQ4Rv7SaHVoy/rLdXFfmADiaFgRmRiHjpNHn9RMj7TxHL8NN1YC+7WPUXHQ5tDX
 FdXxg5vxRpN+xbeFEKF0SrlpyFrEfWejJNc9m7qE07ZSH+gYDMYqFMv5ULjBfw+xIn0RoBfWH
 xyGJ1Rc7uxJTHvDjk5/oVKjljAX1eG3wlkGyprbAjr3AVUtFV34CIxQas/cOTZQ/a6WzosR5/
 drS+K8nMd7Hk/XXaQ4ReK4kmhpvZtbCj05ROVxv9+a3SDFpYubb4V5t/n7u52t7gFhqeYAqcx
 xcsqmfblsUnNdqGZwsscIC1A09i3W40kwFZkFC7cUlREXcSt7VZkQ4k78tXhbXV+9VlcL5m9D
 KxSVG1MsqGVcuVwpFb9iwgrIjlCgtMBghMMNpgLMAyajyFnaz5v7ADkEg+9yr32b2TF8jy3bk
 cIXaFUHsRRkFtmI0UZwr6RClKQfndX/1A1xE+tphxUsOvmzSAusfu73Du4cGjS8wrpaUMjd3A
 O3eJ/wGz+ydTTIv7irilAUf6v8ormW3NQ5AKZgCgPeUAGrKlbWBc+1ZA0pHxy/BE9UCFfO1d2
 kKlBQ6dNkN63D2UMzppyzPEPBI7f+e/SVs1ApAa0xo2F8V2cXpq2CBHMZfW4xQNY9iTIE5qgt
 Iv7aaO/gNfpuPknvWG2UGW8TUSPizEgBJhGG/YqoA6okVrKljuTNC/mS21fZM6NJDWX8fJDsl
 raitd6X5h8phJhHOutm5KzIRRlT6SuUaNKODQ/XFCTaviMDHyeAu1G3/hQ/v+5ILPA9rXJ4Bs
 tVHvktuEg9g4gBtUyJJLrDJ05Nw6YiyuqE7sLdK5uDS99HqVHsualN97gDYgCiPTiexyRy0Ky
 0xlKOUrcBjZ2WUah3ClvgMF9eB9Ffk0QJvthcr7O/bZ5fGVfvUpt0v2urlvKPpnIsf+iGB+Ad
 5nI/849kj/JfugMDOSx4S24fa1kv7j5rJOtW66j80Ie4EmTnyFENshhGGp7Sj3VMTu5JQXO7F
 MxyEU1lEi0rdab5y8T+8cqp7d0kgOydETAtYd6sJS3K0+Uhz69q0VMJNdVxIk0fqgdhO4bVpK
 BqGTpMr2NFbvku4Lm/9gChUO4fED6KJrLbWQZEzU93mY4GSo3TLXxRSLQ08+UZEV/dynE9GLG
 RCltEi9guXHb2RQN+Aw4GJj/HKaS3QQAcpWt5b5CzHJrODyq9CM9vID2cRFziVcyNlQPOG9If
 0/91pEqXXfvoFG/1PvW6jl7IBgHg1mXxXWcro9mW+tqYrzP4rZ9PFhNnt05+VoOdbnjoJpY1q
 KYaSdlWkV84Yo7EjI5XH/Ryc7QXdhLt+hrGUow4jb4z3ewjOXhEyRWVwAehVfpm5cWCoTl+At
 jAC5Qttj3rFRw+OTI9E1MBk1unHDAvtO310k2OlFkMgiWyrAJbLS65J4r63QzNJuuNozCDEfA
 vlwe2jeDKYzMpa3KJ1Efmm+m5BCWL4pTOknoGF3QgKWwAiedVPpDOEHNwPD8aF8bb6fPqnpg8
 MrWUMS8p4AuNiDwhted09k16k24625iiZ1tEq02b3a4lswpD44Wm5tCsxDF8FMZfCMsPW5cjT
 ZD6a7jLDm55Ud6Q5h+Rt6886hChVaIzvQUSL8R6oCqQQZ+ERKgSdiYuZYbrEoalmAYT2abpQ5
 In+P/Q87ANymb6XdMyr5FDBOHTqzyIJ1jSvHi9vAtCoBb/ss7F3P3ZBrWu8P6WH3HmABQiZzO
 xSGhxvXcDEJ6AE3tQDWm7yPDA7fk/1mG+DwScvs+YU1y7nQSAI/mTbLMVDGze1KEBo6dwU5Yj
 c/CN0LKfn7KP04rDh8jhf3C+y1gBu/sRx0sJn2/WrbZqTZSPmwYFf6pgKI0LAUpwfL9muf18E
 KJyTzhqCYTwcmgIVNthT6MiLu+q7SJkTF2tTWAqiOnYljpM1c6rfsbVyj4BR0KPEj33puOfe+
 LeMeRfXzl3bSXk8rNFi+yL8VGYzA8TnBAcLDl11ER7rAM7xOuFf8mi1BKMVWdeybGAi+butrO
 S+912dPC/949w80sInVh++gSeRE0l/CfEwj3DiucoP7SA7EQeXNBs658lG9gffTAAIqhRxK5D
 9O5NwEVQ/R9h7kfSQ/DE0OGt6WCPcOyLo+RvdArRZGcS4U73QAh2B9hmqHsZrmPzX70IYclbk
 oIHZeTtSaBgK1fzRiafar9eWn/tMbO/nPGlC8j27W1YYYnI7HI/nCKtKChjsFlHrInkBUAwD/
 aUNYjGIAThV6er6CX8SvunUYkdvPGs0VfqaQBtS4nNX2dr5IuzBTLgquc2SIJpfdzUVkH3yaO
 VRtPkBxi9y4FYGH9fMxNnMa9nGiklIASXvYpjyNPHkLrZht45uCIZxdIz4EUnJTrQxivWoNXo
 dqPQq6dmC0Mrq+ZHh4a2wgYhypHYob8azX2PjTTWSc6hb3awHqRzvJaUEC3QOz1HgUrJFt/Z9
 GwOgY2Le6tYGZ+u+e5bduCsUurNOHCSMy+k1YM+vJMCVBR2mcDLbU9p6poJxPUTF3g/wWO6D4
 2Lwu8yoFTOkr49tCQL2HDUHS2aS7EThJrPOuLiUciaKLdd4vasgDwG3I4StyfxmfADGM1P5uL
 ftVOpcR9u+3QkTdXdM/pxDpLk8i80V6RJnv3utp9sYatig4F/C3OIvynJRNu3inZ/801SHyWo
 cUe378dmr7G3Xb7Os75LqxH13pNlGzvZcexEXBNV7N+zzxG+sgq2ikrYir4DIK3PH7QEgOz+g
 WGJwRci6Zz/I7Utxr10BiPynia4eIM+U+bnRrGAzodHxM5/pAu5/2/SuhzUPcU9AVaK/liOIh
 r0lG1nGvH0bfsLZBp7lEtBksH4o4a7KQGKT8srv+O49A4tmTuDB2by9O2lodKhx/DQVEiAKku
 Kkj6mWZIHkR/cQyTwyuWQpNFzeAO8ZxZ5n1NcbDDssi+ZuSoMVMlMAbDlhK7ASWxMrX4VI9Gm
 BA6swXS8jsnnG1vMY+FqtRTwiZaxlnLT5wXj1f9zU3G+QqZfSMXAeDeWtFWlRZJjMUWctrT7n
 p28NOsnTP29zYsNjYIJSc0qTCYtyUXlw+qcGjDuEzG04NZ+dp81bMHmJaoVtvF558COHXCzWL
 1ojdDLbarhMPBFrkjJHR0CBatS1P+woiVtrpt9kX3M1PvKbb0MiOYpdNmgiGrkH5zYOKAjJv5
 bOEqWEUFYrKUdMpOFzC+IuMn41tGnmNKuaP9d6NLequWVa4XtZJ/alMvqlTbk3bhSa0ZKj04K
 YVePqKZOF42c818kmFvvBJ84XhHsQ9giNRPF/skebHeh6sdn02w2SIr775l2//zhK/p3xBgsC
 U/YYZWVEzV84d8tcFJ6ULoWUgzz7WydOzsxwOQDSGf5BAjJ3uuUBvn916/OWrJnQTZkLZ8Dw1
 Xru0LXBYtD8hKNyk6olaXZHKTyvVMsjwG1OTChcSwB3x/9nA1SBLShzST8L4V8j6Y3m5GVx0Z
 KM2gSuNU/nkBLqwW//6sUJoXC9n0h2wxc+CL3TNUtP7enBnFKJBrTkenVF5UschFuN+cIOIhY
 BhZ7po0DbT/mE1SqCtBuDTbV0VgeX3lIpaqNtH5vj0R5EdH0BComBPSEfAYpuUu590XYhZCBT
 s/79ovJh3ZdfyEb3N4s3apV9kv61ZFqH7jxbY4Xha+T7Qm7aMLr8clVYBb6Rk7T/MMn+Pnde5
 E/2oEoBRkBm3lPc84ncvruVJy/H9skJSLQFCrckkBAdUmNIRZ/jc3WOSGHUdKI269+DjUGlDw
 YadZFjZMEGN2bjxhlKI1EGi+qm7zlLtG3s9ryLFPXMhhxD7T9OC905nPq0BNbhf/J2ltMgqKC
 BmaQQv74S4hCfY4HdbGPxY0+ar8sTdzzHdAlH0mhRqsla7oqDbgm9F+F8eorT637njAEhldR6
 y4Z7ASpsRJ2pO2hTVGbh3NO4G3+3CQq7e4RGScVRNF14hBKZLKqz9t56RN9QC9aEFr8dYMtEr
 YK2TmNhnRKjegUXyyE3kzuR5KFdtu0bq+m1il0X5rL65026ybSpCuCDQdgGEPb21dExBXBUrZ
 940a8q16n7GsImF7+3J3vmND/RDzqrXfy4S8uBe30d8XeviYt/Izrkj6B6to/knJeOMn7Xow7
 DadFH6YqqfPBrVGpRmb/wwM8idMc9M/KpUjTV0mLe03ZgfDPnZcF+evxsEzhOcedsQ0NvyUit
 SSJub0QMqdpTy83Fy6xexqw2SPDVcsuLtj3OFWT/YkfhMl1vUCyKY0sA2wtpy84At1rUxuB6J
 PzuCBKN85hLVg/+6hN2l7YYOehr0omhJiiAQLdItZqQ389ZFKUONczEAkYwvSLj8k8Kbi/jlg
 mpb4mintAVInTvSlfPlTnJuAdkjB2rJH6qs6uB7TdvmwjqMbae6HD6So95pPf3xz1jt42bnAh
 C0moePey0ZWjqVOXUsTra1qdpy7c4+b9qwmXvJpn6A/z9q2ETPV5rPRwZJ+Mt7nN5OphHMOTy
 AfyKHcaUMOaviTMit/Ea9XGUW+ddo2yHFq6fgIgnjxKIfZev/JQ==
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21239-lists,linux-acpi=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[W_Armin@gmx.de,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	FREEMAIL_FROM(0.00)[gmx.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gmx.de:mid,gmx.de:dkim,gmx.de:email]
X-Rspamd-Queue-Id: A3A121BD192
X-Rspamd-Action: no action

Am 26.02.26 um 19:46 schrieb Rafael J. Wysocki:

> On Thu, Feb 26, 2026 at 7:35=E2=80=AFAM Armin Wolf <W_Armin@gmx.de> wrot=
e:
>> Am 25.02.26 um 22:28 schrieb Rafael J. Wysocki:
>>
>>> On Wed, Feb 25, 2026 at 12:06=E2=80=AFAM Armin Wolf <W_Armin@gmx.de> w=
rote:
>>>> Am 04.02.26 um 22:29 schrieb Armin Wolf:
>>>>
>>>>> The ACPI spec states that the operating system should respond
>>>>> to a fatal ACPI error by "performing a controlled OS shutdown in
>>>>> a timely fashion". Comply with the ACPI specification by powering
>>>>> off the system when ACPICA signals a fatal ACPI error. Users can
>>>>> still disable this behavior by using the acpi.poweroff_on_fatal
>>>>> kernel option to work around firmware bugs.
>>>> Any updates on this?
>>> I was about to apply it, but then I thought that I was not sure about
>>> the Kconfig option.
>>>
>>>    I don't see much value in it TBH.  If you agree, I'll just apply th=
e
>>> patch without that part.
>>>
>>> Thanks!
>> You can drop the Kconfig option if you want.
> OK, applied as 7.1 material.
>
> Please double check
> https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/comm=
it/?h=3Dbleeding-edge&id=3D6f09a7009a1d7a132ddce3a8dd0c46aac66ad8e2

Looks good to me, except that the include of kconfig.h should be dropped n=
ow.

Thanks,
Armin Wolf


